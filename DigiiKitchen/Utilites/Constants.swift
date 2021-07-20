//
//  Constants.swift
//  DigiiKitchen
//
//  Created by Admin on 3/15/19.
//  Copyright © 2019 SnowMan. All rights reserved.
//

import Foundation
import UIKit

class Constants {
    static let VERSION = "1.0"
    static let BASE_URL = "http://206.189.229.7/index.php/mobileapi"
    
    static let USER_LOGIN = BASE_URL + "/loginuser"
    static let REGISTER_USER = BASE_URL + "/registeruser"
    static let GET_CATEGORYLIST = BASE_URL + "/get_category_list"
    static let GET_PRODUCT_LIST = BASE_URL + "/get_receipe_data"
    static let GET_COUNTRY_LIST = BASE_URL + "/get_country_list"
    static let GET_INGREDIENT_CATEGORY = BASE_URL + "/get_ingredient_category"
    static let GET_INGREDIENTS = BASE_URL + "/get_ingredient_data"
}
