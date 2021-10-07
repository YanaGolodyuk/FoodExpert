//
//  ReciepeImageCell.swift
//  FoodExpert
//
//  Created by MacBook on 5.10.21.
//

import UIKit
import SDWebImage

class ReciepeImageCell: UICollectionViewCell {
    
    @IBOutlet weak var reciepImageView: UIImageView!
    @IBOutlet weak var reciepeLabel: UILabel!
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reciepImageView.image = nil
    }
    
    func configure(receip: Recipe) {
        reciepImageView.sd_setImage(with: URL(string: receip.image), placeholderImage: UIImage(named: "recipe_placeholder.png"))
        reciepeLabel.text = receip.label
    }
}
