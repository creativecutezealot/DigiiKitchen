//
//  IngredientItem.swift
//  DigiiKitchen
//
//  Created by Admin on 3/26/19.
//  Copyright © 2019 SnowMan. All rights reserved.
//

import Foundation
class IngredientItem : NSObject {
    var _id = "-1"
    var name = ""
    var img = ""
    var quantity = ""
    var price = ""
    var convert = ""
    var unit = ""
    
    override init() {
        super.init()
    }
    init(dict: [String : Any]) {
        if let val = dict["ingredient_id"] as? String                      { _id = val }
        if let val = dict["name"] as? String                    { name = val }
        if let val = dict["picture"] as? String                 {
            img = "http://206.189.229.7//cdn/ingredients/\(val)"
        }
        if let val = dict["quantity"] as? String      { quantity = val }
        if let val = dict["gr_price"] as? String      { price = val }
        if let val = dict["gr_convert"] as? String      { convert = val }
        if let val = dict["w_unit"] as? String      { unit = val }
    }
}
