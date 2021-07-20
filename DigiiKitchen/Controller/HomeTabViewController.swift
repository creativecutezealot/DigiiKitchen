//
//  HomeTabViewController.swift
//  DigiiKitchen
//
//  Created by Admin on 3/17/19.
//  Copyright © 2019 SnowMan. All rights reserved.
//

import UIKit
import KVNProgress
import SwipeCellKit
//import Kingfisher

class HomeTabViewController: UIViewController {
    
    var category_index = 0
    var categoryListOrigin : [CategoryItem] = []
    var categoryList : [CategoryItem] = []
    var paging_count = 0
    @IBOutlet weak var tblProduct: UITableView!
    
    var searchResult : [ProductItem] = []
    var searchWorkingNow = false
    
    
    @IBOutlet weak var collectionViewWindow: UICollectionView!
    @IBOutlet weak var txtSerachTitle: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.categoryReload), name: NSNotification.Name(rawValue: "dismissCateSel"), object: nil)
        
        let selectedCategoryItem = CategoryItem.init()
        categoryList.append(selectedCategoryItem)
        onloadCategoryList()
        onloadProducts(page_offset: 0, product_name: txtSerachTitle.text!,search: true, cList: categoryList)
        paging_count = 10
        // Do any additional setup after loading the view.
    }
    
    @objc func categoryReload(notification : NSNotification){
        let data = notification.object as! [CategoryItem]
        categoryList = data
        let categoryItem = CategoryItem.init()
        categoryList.insert(categoryItem, at: 0)
        collectionViewWindow.reloadData()
        paging_count = 10
        onloadProducts(page_offset: 0, product_name: txtSerachTitle.text!, search: true, cList: categoryList)
    }
  
    @IBAction func onSearchProduct(_ sender: Any) {
        print("key typed")
        if txtSerachTitle.text!.count > 2 || txtSerachTitle.text!.count == 0{
            print("serach require")
            paging_count = 10
            onloadProducts(page_offset: 0, product_name: txtSerachTitle.text!,search: true, cList: categoryList)
        }
        
    }
    
    //load category list from server
    
    func onloadCategoryList(){
        let body = [
            "category": "all"
            ] as [String : Any]
        KVNProgress.show()
        ApiService.shared.getCategoryList(body: body, completion: {
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
                    self.categoryListOrigin = []
                    let res = obj!["data"] as? [Any]
                    
                    for c in res! {
                        let item = CategoryItem(dict : c as! [String : Any])
                        self.categoryListOrigin.append(item)
                        self.categoryList.append(item)
                    }
                    
                    Globals.CATEGORY_LIST = self.categoryListOrigin
                    self.collectionViewWindow.reloadData()
                    
                }
            }
            else {
                KVNProgress.showError(withStatus: "error")
            }
        })
        
    }
    
    func onloadProducts(page_offset : Int,product_name : String, search : Bool, cList : [CategoryItem]){
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
        
        ApiService.shared.getProductList(body : body, completion: {
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
                    if(search) {self.searchResult = []}
                    let res = obj!["data"] as? [Any]
                    for c in res! {
                        
                        let item = ProductItem.init(dict : c as! [String : Any])
                        self.searchResult.append(item)
                    }
                    self.tblProduct.reloadData()
                }
            }
            else {
                KVNProgress.showError(withStatus: "error")
            }
        })
    }
    
 
    
}

extension HomeTabViewController : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        for c in collectionView.visibleCells {
            let i = collectionView.indexPath(for: c)
            category_index = i!.item
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "PopupCategoryViewController") as! PopupCategoryViewController
            present(vc, animated: true, completion: nil)
        }else{
         //   var filterCategoryList : [CategoryItem] = []
            var newcategoryList : [CategoryItem] = []
            let categoryItem = CategoryItem.init()
            newcategoryList.insert(categoryItem, at: 0)
            if (categoryList[indexPath.item].name == "All"){
                for globalItem in Globals.CATEGORY_LIST{
                    globalItem.selected = "yes"
                    newcategoryList.append(globalItem)
                }
            }else{
                let allcategoryItem = CategoryItem.init()
                allcategoryItem.name = "All"
                newcategoryList.append(allcategoryItem)
                newcategoryList.append(categoryList[indexPath.item])
                for globalItem in Globals.CATEGORY_LIST
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
            
            onloadProducts(page_offset: 0, product_name: txtSerachTitle.text!, search: true, cList: categoryList)
        }
    }
}
extension HomeTabViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategorySliderCollectionViewCell", for: indexPath) as! CategorySliderCollectionViewCell
        if(indexPath.item==0) {
            cell.img_icon.isHidden = false
            cell.lblCategory.isHidden = true
        }else {
            cell.img_icon.isHidden = true
            cell.lblCategory.isHidden = false
            cell.lblCategory.text = categoryList[indexPath.item].name
        }
        return cell
    }
    
}

extension HomeTabViewController  : UICollectionViewDelegateFlowLayout{
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



extension HomeTabViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("show cell  : ", indexPath.item)
        
        if indexPath.item + 2 > searchResult.count &&  searchResult.count >= paging_count{
            let newPage = self.searchResult.count
            print("req new products : ", newPage)
            onloadProducts(page_offset : newPage,product_name : txtSerachTitle.text!, search: false, cList: categoryList)
            paging_count += 10
          //  tblProduct.reloadData()
        }
    }
}
extension HomeTabViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
        
        let product = searchResult[indexPath.row]
        cell.lblProductName.text = product.title
        cell.lblProductCall.text = product.calories
        cell.lblProductTime.text = product.cooking_time
        cell.imgProductItem.kf.setImage(with: URL(string: product.img), placeholder: UIImage(named: "ic_load"), options: [.cacheOriginalImage])
        
        cell.delegate = self
        return cell
    }
}

extension HomeTabViewController : SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else {
            return nil
        }
        let chartAction = SwipeAction(style: .default, title: " Add T Cart ", handler: { action , indexPath in
        })
        
        chartAction.backgroundColor = UIColor(red: 248/255, green: 161/255, blue: 38/255, alpha: 1)
    //    chartAction.image = UIImage(named: "ic_cart")
        return [chartAction]
    }
}
