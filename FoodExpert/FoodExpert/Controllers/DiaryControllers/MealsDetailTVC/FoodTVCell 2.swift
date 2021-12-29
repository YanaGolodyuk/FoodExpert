//
//  FoodTVCell.swift
//  FoodExpert
//
//  Created by admin on 05.10.2021.
//

import UIKit

class FoodTVCell: UITableViewCell {

    @IBOutlet weak var foodNameLbl: UILabel!
    @IBOutlet weak var foodCaloriesLbl: UILabel!
    @IBOutlet weak var rgammsCountLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
