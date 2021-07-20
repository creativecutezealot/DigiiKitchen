//
//  Ing_Category.swift
//  DigiiKitchen
//
//  Created by Admin on 3/26/19.
//  Copyright © 2019 SnowMan. All rights reserved.
//

import Foundation
class IngCategory : NSObject {
    var _id = "-1"
    var name = ""
    var selected = "no"
    override init() {
        super.init()
    }
    init(dict: [String : Any]) {
        if let val = dict["category_id"] as? String                      { _id = val }
        if let val = dict["title"] as? String                      { name = val }
    }
}
