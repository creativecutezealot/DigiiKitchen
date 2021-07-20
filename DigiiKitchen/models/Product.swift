//
//  Product.swift
//  DigiiKitchen
//
//  Created by Admin on 3/19/19.
//  Copyright © 2019 SnowMan. All rights reserved.
//

import Foundation
import UIKit

class ProductItem : NSObject {
    var _id = "-1"
    var title = ""
    var img = ""
    var firstname = ""
    var lastname = ""
    var serves = ""
    var descript = ""
    var calories = ""
    var cooking_time = ""
    var img_src : UIImage? = nil
    override init() {
        super.init()
    }
    init(dict: [String : Any]) {
        if let val = dict["recipe_id"] as? String                      { _id = val }
        if let val = dict["title"] as? String                      { title = val }
        if let val = dict["featured_image"] as? String
        { img = "http://206.189.229.7//cdn/recipes/\(val)"}
        if let val = dict["firstname"] as? String                      { firstname = val }
        if let val = dict["lastname"] as? String                      { lastname = val }
        if let val = dict["serves"] as? String                      { serves = val }
        if let val = dict["description"] as? String                      { descript = val }
        if let val = dict["calories"] as? String                      { calories = "\(val)Cal" }
        if let val = dict["cooking_time"] as? String                   {cooking_time = val}
        
    }
}
