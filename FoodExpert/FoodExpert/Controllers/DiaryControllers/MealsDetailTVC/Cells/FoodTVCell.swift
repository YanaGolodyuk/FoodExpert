import UIKit

class FoodTVCell: UITableViewCell {

    @IBOutlet weak var foodNameLbl: UILabel!
    @IBOutlet weak var foodCaloriesLbl: UILabel!
    @IBOutlet weak var rgammsCountLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(by meal: Meal) {
        foodNameLbl.text = meal.foodName
        foodCaloriesLbl.text = "\(meal.calories) kcal"
        rgammsCountLbl.text = "\(meal.measureType ?? "")"
    }
}
