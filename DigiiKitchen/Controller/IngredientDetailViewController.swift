//
//  IngredientDetailViewController.swift
//  DigiiKitchen
//
//  Created by Admin on 3/27/19.
//  Copyright © 2019 SnowMan. All rights reserved.
//

import UIKit

class IngredientDetailViewController: UIViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtQuantity: UITextField!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var imgIngredient: UIImageView!
    
    @IBOutlet weak var txtUnit: UITextField!
    @IBOutlet weak var lblEquals: UILabel!
    @IBOutlet weak var lblUnits: UILabel!
    
    @IBOutlet weak var lblLogsFirstQuantity: UILabel!
    @IBOutlet weak var lblLogsUnit: UILabel!
    @IBOutlet weak var lblLogsGrams: UILabel!
    @IBOutlet weak var lblLogsDate: UILabel!
    
    @IBOutlet weak var lblSLogsQuantity: UILabel!
    @IBOutlet weak var lblSLogsUnit: UILabel!
    @IBOutlet weak var lblSLogsGrams: UILabel!
    @IBOutlet weak var lblSLogsDate: UILabel!
    
    var ingredientItem : IngredientItem = IngredientItem.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatIniitailView()
        // Do any additional setup after loading the view.
    }
    

    func formatIniitailView(){
        txtDescription.text = ""
        txtQuantity.text = ingredientItem.quantity
        txtPrice.text = ingredientItem.price
        lblEquals.text = ingredientItem.convert
        lblTitle.text = ingredientItem.name
        
        txtQuantity.layer.borderColor =  UIColor(red: 17/255, green: 105/255, blue: 48/255, alpha: 0.7).cgColor
        txtQuantity.layer.borderWidth = 2
        
        imgIngredient.kf.setImage(with: URL(string: ingredientItem.img), placeholder: UIImage(named: "ic_load"), options: [.cacheOriginalImage])
    }
    @IBAction func onTappedBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    

}
