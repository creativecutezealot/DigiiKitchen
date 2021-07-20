//
//  mainService.swift
//  TrackPorker
//
//  Created by Admin on 3/14/19.
//  Copyright © 2019 SnowMan. All rights reserved.
//

import Foundation
import UIKit
class  MainService {
    static let shared = MainService()
    private init(){}
    
    func showAlert(viewCtrl: UIViewController, title: String, msg: String) {
        
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        viewCtrl.present(alert, animated: true, completion: nil)
        
        // change to desired number of seconds (in this case 5 seconds)
        let when = DispatchTime.now() + 5
        DispatchQueue.main.asyncAfter(deadline: when){
            // your code with delay
            alert.dismiss(animated: true, completion: nil)
        }
        
    }
}
