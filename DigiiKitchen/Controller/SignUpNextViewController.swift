//
//  SignUpNextViewController.swift
//  DigiiKitchen
//
//  Created by Admin on 3/14/19.
//  Copyright © 2019 SnowMan. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import KVNProgress

class SignUpNextViewController: UIViewController {

    var photo : Data? = nil
    var FirstName : String = ""
    var LastName : String = ""
    var UserName : String = ""
    var Email : String = ""
    var Birthday : String = ""
    var countryList : [CountryItem] = []
    var selectedCountryId = "-1"
    
    @IBOutlet weak var txtDescription: UITextView!
    
    @IBOutlet weak var txtCountryName: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtPwd: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtConfirmPwd: SkyFloatingLabelTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        get_country_list()
        NotificationCenter.default.addObserver(self, selector: #selector(self.countrySelected), name: NSNotification.Name(rawValue: "dismissCountrySel"), object: nil)
        
    }
    
    func configureView() {
//        txtCountryName.delegate = self
    }
    
    @objc func countrySelected(notification : NSNotification){
        let data = notification.object as! CountryItem
        selectedCountryId = data._id
        txtCountryName.text = data.name
        
    }
    
    @IBAction func onSearchCountry(_ sender: Any) {
        print("start country")
        let vc = storyboard?.instantiateViewController(withIdentifier: "SearchCountryViewController") as! SearchCountryViewController
        vc.countryList = countryList
        present(vc, animated: true, completion: nil)
        
    }
    @IBAction func onBackTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func get_country_list(){
        let body = [
            "req": "country_list"
            ] as [String : Any]
        KVNProgress.show()
        ApiService.shared.get_country_list(body: body, completion: {
            error, object in
            KVNProgress.dismiss()
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
                    self.countryList = []
                    let res = obj!["data"] as? [Any]
                    for c in res! {
                        let item = CountryItem.init(dict : c as! [String : Any])
                        self.countryList.append(item)
                    }
                    Globals.COUNTRY_LIST = self.countryList
                }
            }
            else {
                KVNProgress.showError(withStatus: "error")
            }
        })
    }
    
  
    
    @IBAction func onSignUpTapped(_ sender: Any) {
        
        if(txtPwd.text != txtConfirmPwd.text && txtPwd.text == "" ){
            MainService.shared.showAlert(viewCtrl: self, title: "Sorry !", msg:"please check your password correction")
            return
        }
        
        let body = [
            "username" : UserName ,
            "firstname" : FirstName,
            "lastname" : LastName,
            "description" : txtDescription.text!,
            "email" : Email,
            "country_id" : selectedCountryId,
            "password" : txtPwd.text!,
            "password_2" : txtConfirmPwd.text!
        ] as [String : Any]
        
        let filename = getDocumentsDirectory().appendingPathComponent("pavatar.png")
        if photo != nil {
            
            do {
                try photo!.write(to: filename)
            } catch {
                print(error.localizedDescription)
            }
        }else{
            photo = UIImage.init(named: "profile")?.pngData()
            
            do {
                try photo!.write(to: filename)
            } catch {
                print(error.localizedDescription)
            }
        }
        
//
        KVNProgress.show()
        ApiService.shared.registerUser(file: filename, parameters: body, completion: {
                error, object in
                if error != nil {
                    KVNProgress.showError(withStatus: error!.localizedDescription)
                }
                else {
                    let obj = object as? NSDictionary
                    if obj != nil {
                        let err = obj!["message"] as? NSDictionary
                        if err != nil {
                            let detail = err!["user"] as! String
                            KVNProgress.showError(withStatus: detail)
                            return
                        }
                        
                        print(obj!["message"] as Any)
                        KVNProgress.dismiss()
                        let message = obj!["message"] as! String
                        if(message=="success"){
                            UserDefaults.standard.set("logined", forKey: "user-id")
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                        else{
                            MainService.shared.showAlert(viewCtrl: self, title: "Your SignUp Response", msg:message)
                        }
                    }
                }
            })
        
        
        
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
