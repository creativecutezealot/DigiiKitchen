//
//  LoginViewController.swift
//  DigiiKitchen
//
//  Created by Admin on 3/13/19.
//  Copyright © 2019 SnowMan. All rights reserved.
//

import UIKit
import KVNProgress

class LoginViewController: UIViewController {

    @IBOutlet weak var emailConView: UIView!
    @IBOutlet weak var psdConView: UIView!
    @IBOutlet weak var txtUserEmail: UITextField!
    @IBOutlet weak var txtUserPwd: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    

    func configureView() {
        
        let color = UIColor(red: 249/255, green: 173/255, blue: 42/255, alpha: 1).cgColor
        
        emailConView.layer.borderColor = color
        psdConView.layer.borderColor = color
    }
    
    @IBAction func onTappedRegister(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onTappedLogin(_ sender: Any) {
        let body = [
            "email": txtUserEmail.text!,
            "password": txtUserPwd.text!
            ] as [String : Any]
        KVNProgress.show()
        ApiService.shared.loginUser(body: body, completion: {
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
                    UserDefaults.standard.set("logined", forKey: "user-id")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                    return
                }
                
                MainService.shared.showAlert(viewCtrl: self, title: "Your Login Response", msg:status)
                Globals.SESSION_STATE = ""
                NSLog("Finish success")
                Globals.SESSION_ID = ""
            }
            else {
                KVNProgress.showError(withStatus: "error")
            }
        })
        
    }
    
    

}
