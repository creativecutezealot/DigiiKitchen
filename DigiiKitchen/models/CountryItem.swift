//
//  CountryItem.swift
//  DigiiKitchen
//
//  Created by Admin on 3/21/19.
//  Copyright © 2019 SnowMan. All rights reserved.
//

import Foundation
class CountryItem : NSObject {
    var _id = "0"
    var name = ""
    override init() {
        super.init()
    }
    init(dict: [String : Any]) {
        if let val = dict["country_id"] as? String                      { _id = val }
        if let val = dict["nicename"] as? String                      { name = val }
    }
}
