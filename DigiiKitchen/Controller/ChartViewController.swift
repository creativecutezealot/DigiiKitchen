//
//  ChartViewController.swift
//  DigiiKitchen
//
//  Created by Admin on 3/17/19.
//  Copyright © 2019 SnowMan. All rights reserved.
//

import UIKit
import KVNProgress
class ChartViewController: UIViewController {

    var categoryList : [IngCategory] = []
    var ingredientList : [IngredientItem] = []
    var searchWorkingNow : Bool = false
    
    var pagingCount = 10
    @IBOutlet weak var collectionCategoryList: UICollectionView!
    @IBOutlet weak var tblIngredients: UITableView!
    @IBOutlet weak var txtSearchIngredient: UITextField!
    
    var category_index = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.categoryReload), name: NSNotification.Name(rawValue: "dismissIngCateSel"), object: nil)
        
        let selectedCategoryItem = IngCategory.init()
        categoryList.append(selectedCategoryItem)
        get_category_list()
        onloadIngredients(page_offset: 0, product_name: "", search: true, cList: categoryList)
    }
    
    @objc func categoryReload(notification : NSNotification){
        print("here")
        let data = notification.object as! [IngCategory]
        categoryList = data
        let categoryItem = IngCategory.init()
        categoryList.insert(categoryItem, at: 0)
        collectionCategoryList.reloadData()
        onloadIngredients(page_offset: 0, product_name: txtSearchIngredient.text!, search: true, cList: categoryList)
    }
    
    @IBAction func onSearchImgredients(_ sender: Any) {
        if txtSearchIngredient.text!.count > 2 || txtSearchIngredient.text!.count == 0{
            print("serach require")
            onloadIngredients(page_offset: 0, product_name: txtSearchIngredient.text!,search: true, cList: categoryList)
        }
        
    }
    
    
    
    func get_category_list(){
        let body = [
            "category": "all"
            ] as [String : Any]
        KVNProgress.show(withStatus: "", on: view)
        ApiService.shared.get_ingredient_category(body : body, completion: {
            error, object in
            if error == nil {
                
                let obj = object as? NSDictionary
                if obj != nil {
                    let err = obj!["error"] as? NSDictionary
                    if err != nil {
                        let detail = err!["detail"] as! String
                        NSLog("error message \(detail)")
                        return
                    }
                }
                KVNProgress.dismiss()
                let status = obj!["message"] as! String
                if(status == "success"){
                    self.categoryList = []
                    let res = obj!["data"] as? [Any]
                    
                    for c in res! {
                        let item = IngCategory(dict : c as! [String : Any])
                        self.categoryList.append(item)
                    }
                    
                    Globals.INGR_CATEGORY_LIST = self.categoryList
                    self.collectionCategoryList.reloadData()
                    
                }
            }
            else {
                KVNProgress.showError(withStatus: "error")
            }
        })
        
        
    }
    
    @IBAction func onBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func onloadIngredients(page_offset : Int,product_name : String, search : Bool, cList : [IngCategory]){
        var category_filter : [String] = []
        for cate_item in cList {
            category_filter.append(cate_item._id)
        }
        let body = [
            "category": category_filter,
            "offset" : page_offset,
            "title" : product_name
            ] as [String : Any]
        
        if(!searchWorkingNow){
            searchWorkingNow = true
        }else{
            return
        }
        
        ApiService.shared.get_ingredient_list(body : body, completion: {
            error, object in
            self.searchWorkingNow = false
            if error == nil {
                let obj = object as? NSDictionary
                if obj != nil {
                    let err = obj!["error"] as? NSDictionary
                    if err != nil {
                        let detail = err!["detail"] as! String
                        NSLog("error message \(detail)")
                        return
                    }
                }
                let status = obj!["message"] as! String
                if(status == "success"){
                    if(search) {
                        self.ingredientList = []
                        self.pagingCount = 10
                    }
                    let res = obj!["data"] as? [Any]
                    for c in res! {
                        let item = IngredientItem.init(dict : c as! [String : Any])
                        self.ingredientList.append(item)
                    }
                    self.tblIngredients.reloadData()
                }
            }
            else {
                KVNProgress.showError(withStatus: "error")
            }
        })
    }
    
}
extension ChartViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        for c in collectionView.visibleCells {
            let i = collectionView.indexPath(for: c)
            category_index = i!.item
            break
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        
        if indexPath.row == 0 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "PopUpIngCategoryViewController") as! PopUpIngCategoryViewController
            present(vc, animated: true, completion: nil)
        }else{
            //   var filterCategoryList : [CategoryItem] = []
            var newcategoryList : [IngCategory] = []
            let categoryItem = IngCategory.init()
            newcategoryList.insert(categoryItem, at: 0)
            if (categoryList[indexPath.item].name == "All"){
                for globalItem in Globals.INGR_CATEGORY_LIST{
                    globalItem.selected = "yes"
                    newcategoryList.append(globalItem)
                }
            }else{
                let allcategoryItem = IngCategory.init()
                allcategoryItem.name = "All"
                newcategoryList.append(allcategoryItem)
                newcategoryList.append(categoryList[indexPath.item])
                for globalItem in Globals.INGR_CATEGORY_LIST
                {
                    if(categoryList[indexPath.item]._id == globalItem._id){
                        globalItem.selected = "yes"
                    }else{
                        globalItem.selected = "no"
                    }
                }
            }
            categoryList = newcategoryList
            collectionView.reloadData()
            onloadIngredients(page_offset : 0, product_name: txtSearchIngredient.text!, search: true, cList: categoryList)
    }
        
    }
    @objc func goToDetail(button : UIButton){
        print("button clicked! \(button.tag)")
        let vc = storyboard?.instantiateViewController(withIdentifier: "IngredientDetailViewController") as! IngredientDetailViewController
        vc.ingredientItem = ingredientList[button.tag]
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
    
extension ChartViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IngCategoryCollectionViewCell", for: indexPath) as! IngCategoryCollectionViewCell
        if(indexPath.item==0) {
            cell.icon_image.isHidden = false
            cell.lblCategoryName.isHidden = true
        }else {
            cell.icon_image.isHidden = true
            cell.lblCategoryName.isHidden = false
            cell.lblCategoryName.text = categoryList[indexPath.item].name
        }
        return cell
    }
}
extension ChartViewController  : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellSize = CGSize(width: CGFloat(0), height: 0)
        var width = 0
        if indexPath.item == 0{
            width = 45
        }else {
            width = categoryList[indexPath.item].name.count * 11 + 8
        }
        let height = collectionView.frame.height
        cellSize = CGSize(width: CGFloat(width), height: CGFloat(height))
        return cellSize
    }
}
extension ChartViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("show cell  : ", indexPath.item)
        
        if indexPath.item + 2 > ingredientList.count &&  ingredientList.count >= pagingCount {
            let newPage = self.ingredientList.count
            print("req new products : ", newPage)
            onloadIngredients(page_offset: newPage,product_name : txtSearchIngredient.text!, search: false, cList: categoryList)
            pagingCount += 10
            //  tblProduct.reloadData()
        }
    }
    
   
}
extension ChartViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientItemTableViewCell", for: indexPath) as! IngredientItemTableViewCell
        let product = ingredientList[indexPath.row]
        cell.lblTitle.text = product.name
        cell.lblQuality.text = product.quantity
        cell.img_ingred.kf.setImage(with: URL(string: product.img), placeholder: UIImage(named: "ic_load"), options: [.cacheOriginalImage])
        
        cell.btnDetail?.addTarget(self, action: #selector(self.goToDetail), for: .touchUpInside)
        cell.btnDetail.tag = indexPath.item
        
        return cell
    }
}

