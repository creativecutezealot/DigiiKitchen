//
//  CountryItemTableViewCell.swift
//  DigiiKitchen
//
//  Created by Admin on 3/21/19.
//  Copyright © 2019 SnowMan. All rights reserved.
//

import UIKit

class CountryItemTableViewCell: UITableViewCell {

    @IBOutlet weak var lblId: UILabel!
    @IBOutlet weak var lblCountryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
