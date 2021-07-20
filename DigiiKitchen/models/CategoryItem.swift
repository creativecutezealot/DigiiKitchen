//
//  CategoryItem.swift
//  DigiiKitchen
//
//  Created by Admin on 3/19/19.
//  Copyright © 2019 SnowMan. All rights reserved.
//

import Foundation
class CategoryItem : NSObject {
    var _id = "-1"
    var name = ""
    var img = ""
    var selected = "no"
    override init() {
        super.init()
    }
    init(dict: [String : Any]) {
        if let val = dict["_id"] as? String                      { _id = val }
        if let val = dict["name"] as? String                      { name = val }
    }
}
