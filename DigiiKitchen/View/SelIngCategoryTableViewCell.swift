//
//  SelIngCategoryTableViewCell.swift
//  DigiiKitchen
//
//  Created by Admin on 3/26/19.
//  Copyright © 2019 SnowMan. All rights reserved.
//

import UIKit

class SelIngCategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCateNum: UILabel!
    @IBOutlet weak var lblCateName: UILabel!
    @IBOutlet weak var imgCateSelectState: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
