
//
//  SearchCountryViewController.swift
//  DigiiKitchen
//
//  Created by Admin on 3/21/19.
//  Copyright © 2019 SnowMan. All rights reserved.
//

import UIKit

class SearchCountryViewController: UIViewController {

    var countryList : [CountryItem] = []
    @IBOutlet weak var searchWord: UITextField!
    @IBOutlet weak var tblCountryList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSearchDone(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSearchCountryType(_ sender: Any) {
        print("serach typed : \(String(describing: searchWord.text))")
        countryList = serach_country(text: searchWord.text!)
        tblCountryList.reloadData()
        
    }
    
    func serach_country(text : String)->([CountryItem]){
        var returnList : [CountryItem] = []
        for item in Globals.COUNTRY_LIST {
            if item.name.lowercased().contains(text.lowercased()){
                returnList.append(item)
            }
        }
        return returnList
    }
    
    
    
    
    
}
extension SearchCountryViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryItemTableViewCell" , for: indexPath)
        as! CountryItemTableViewCell
        let item = countryList[indexPath.item]
        cell.lblId.text = item._id
        cell.lblCountryName.text = item.name
        return cell
    }
    
    
}
extension SearchCountryViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected \(indexPath.item)")
        
        dismiss(animated: true, completion:{
            print("dismissed !")
            let selectedItem = self.countryList[indexPath.item]
            NotificationCenter.default.post(name : NSNotification.Name(rawValue: "dismissCountrySel"), object : selectedItem)
        })
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
}
