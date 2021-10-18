import UIKit

class AddFoodTVCell: UITableViewCell {

    @IBOutlet weak var foodNameLbl: UILabel!
    @IBOutlet weak var brandLbl: UILabel!
    @IBOutlet weak var caloriesCountLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(food: Food){
        foodNameLbl.text = food.label
        guard let brand = food.brand else {return}
        brandLbl.text = brand + "·"
        caloriesCountLbl.text = "\(Int(food.nutrients.ENERC_KCAL)) kcal"
    }
}
