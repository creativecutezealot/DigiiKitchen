//
//  IngredientItemTableViewCell.swift
//  DigiiKitchen
//
//  Created by Admin on 3/26/19.
//  Copyright © 2019 SnowMan. All rights reserved.
//

import UIKit

class IngredientItemTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var img_ingred: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblQuality: UILabel!
    @IBOutlet weak var lblExp: UILabel!
    @IBOutlet weak var btnDetail: UIButton!
    
    var selectId = "-1"
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func onAddToList(_ sender: Any) {
        print("Add To List : \(selectId)")
    }
    
}
