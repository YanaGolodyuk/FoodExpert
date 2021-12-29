import UIKit

protocol MealTableViewCellDelegate: AnyObject {
    func didTapAddMealButton(with title: String)
}

class MealTableViewCell: UITableViewCell{
    
    weak var delegate: MealTableViewCellDelegate?

    private var title: String = ""
    
    @IBOutlet weak var mealLabel: UILabel!
    @IBOutlet weak var addMealButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    @IBAction func addButtonAction(_ sender: UIButton) {
        self.title = mealLabel.text!
        delegate?.didTapAddMealButton(with: title)
    }
    
}
