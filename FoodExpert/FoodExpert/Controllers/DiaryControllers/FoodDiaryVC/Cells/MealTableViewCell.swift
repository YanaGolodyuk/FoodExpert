//
//  MealTableViewCell.swift
//  FoodExpert
//
//  Created by admin on 30.09.2021.
//

import UIKit

class MealTableViewCell: UITableViewCell{

    @IBOutlet weak var mealLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
