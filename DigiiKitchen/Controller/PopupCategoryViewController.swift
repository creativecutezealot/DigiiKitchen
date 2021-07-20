//
//  PopupCategoryViewController.swift
//  DigiiKitchen
//
//  Created by Admin on 3/18/19.
//  Copyright © 2019 SnowMan. All rights reserved.
//

import UIKit
import KVNProgress

class PopupCategoryViewController: UIViewController {
    var categoryLists : [CategoryItem] = []

    @IBOutlet weak var categoryTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryLists = Globals.CATEGORY_LIST
        
    }
    @IBAction func onTappedDone(_ sender: Any) {
        dismiss(animated: true, completion:{
            print("dismissed !")
            var selectedCategory : [CategoryItem] = [];
            for filter_item in self.categoryLists {
                if filter_item.selected == "yes" {
                    selectedCategory.append(filter_item)
                }
            }
            Globals.CATEGORY_LIST = self.categoryLists
            NotificationCenter.default.post(name : NSNotification.Name(rawValue: "dismissCateSel"), object : selectedCategory)
        })
    }
    
    @IBAction func onCheckAll(_ sender: Any) {
        if (categoryLists.count > 0){
            if(categoryLists[0].selected == "yes"){
                for item in categoryLists {
                    item.selected = "no"
                }
            }else{
                for item in categoryLists {
                    item.selected = "yes"
                }
            }
        }
        categoryTable.reloadData()
        
    }
    
}
extension PopupCategoryViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if categoryLists[indexPath.row].selected == "yes" {
            categoryLists[indexPath.row].selected = "no"
        }else{
            categoryLists[indexPath.row].selected = "yes"
        }
        categoryTable.reloadData()
        
    }
}


extension PopupCategoryViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryLists.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelCategoryTableViewCell", for: indexPath) as! SelCategoryTableViewCell
        
        let productName = categoryLists[indexPath.row].name
        cell.lblCateName.text = productName
        cell.lblCateNum.text = "\(indexPath.row+1)"
        cell.imgCateSelectState.image = UIImage(named: categoryLists[indexPath.row].selected == "yes" ? "ic_checked" : "ic_unchecked")
        return cell
    }
}

