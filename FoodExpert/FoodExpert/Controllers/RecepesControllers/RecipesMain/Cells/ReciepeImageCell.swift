import UIKit
import SDWebImage

class ReciepeImageCell: UICollectionViewCell {
    
    @IBOutlet weak var reciepImageView: UIImageView!
    @IBOutlet weak var reciepeLabel: UILabel!
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reciepImageView.image = nil
    }
    
    func configure(recipe: Recipe) {
        reciepImageView.sd_setImage(with: URL(string: recipe.image), placeholderImage: UIImage(named: "recipe_placeholder.png"))
        reciepeLabel.text = recipe.label
        reciepeLabel.textColor = .white
    }
}
