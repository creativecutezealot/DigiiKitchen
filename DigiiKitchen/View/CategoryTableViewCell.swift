
//
//  CategoryTableViewCell.swift
//  DigiiKitchen
//
//  Created by Admin on 3/18/19.
//  Copyright © 2019 SnowMan. All rights reserved.
//

import UIKit
import SwipeCellKit
import Kingfisher

class CategoryTableViewCell: SwipeTableViewCell {
    
    @IBOutlet weak var imgProductItem: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProductTime: UILabel!
    @IBOutlet weak var lblProductCall: UILabel!
    
    @IBOutlet weak var lblProductVisit: UILabel!
    @IBOutlet weak var lblProductFavoritesNum: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
