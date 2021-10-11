import UIKit

class FoodSearchDetailVC: UIViewController {
    
    var foodHints: FoodHint?
    var meal: String?
    var gramsQuantity: Int = 0
    var measureType: String?
    
    var calcTotalCalories: Int = 0
    var calcCarbs: Double = 0
    var calcFats: Double = 0
    var calcProteins: Double = 0
    var currentFoodName: String = ""
    
    var currentRoundedResultDoubleValue: Double = 0
    var currentRoundedResultDoubleValueInt: Int = 0
    
    @IBOutlet weak var foodNameLbl: UILabel!
    
    @IBOutlet weak var quantityTF: UITextField!
    @IBOutlet weak var typeQuantityPickerView: UIPickerView!
    @IBOutlet weak var totalCaloriesCountLbl: UILabel!
    @IBOutlet weak var mealPickerView: UIPickerView!
    
    @IBOutlet weak var proteinsCountLbl: UILabel!
    @IBOutlet weak var fatsCountLbl: UILabel!
    @IBOutlet weak var carbsCountLbl: UILabel!
    
    @IBAction func addMealAction(_ sender: Any) {
        CoreDataManger.shared.addMeal(calories: calcTotalCalories, mealType: meal, carbs: calcCarbs, fats: calcFats, proteins: calcProteins, foodName: currentFoodName, measureType: measureType)
        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "mealAdded"), object: nil)
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        typeQuantityPickerView.dataSource = self
        typeQuantityPickerView.delegate = self
        mealPickerView.dataSource = self
        mealPickerView.delegate = self
        quantityTF.text = "1"
        gramsQuantity = Int(foodHints?.measures.first?.weight ?? Float(0))
        configure()
    }
    
    func configure() {
        guard let foodHints = foodHints else { return }
        
        if let calcTotalCaloriesString = NumberFormatter().number(from: "\(calcNutriesCount(nutrientType: foodHints.food.nutrients.ENERC_KCAL) ?? "0")"),
           let calcCarbsString = NumberFormatter().number(from: "\(calcNutriesCount(nutrientType: foodHints.food.nutrients.CHOCDF) ?? "0")"),
           let calcFatsString = NumberFormatter().number(from: "\(calcNutriesCount(nutrientType: foodHints.food.nutrients.FAT) ?? "0")"),
           let calcProteinsString = NumberFormatter().number(from: "\(calcNutriesCount(nutrientType: foodHints.food.nutrients.PROCNT) ?? "0")") {
            let calcTotalCaloriesInt = calcTotalCaloriesString.intValue
            calcTotalCalories = calcTotalCaloriesInt
            let calcCarbsDouble = calcCarbsString.doubleValue
            calcCarbs = calcCarbsDouble
            let calcFatsDouble = calcFatsString.doubleValue
            calcFats = calcFatsDouble
            let calcProteinsDouble = calcProteinsString.doubleValue
            calcProteins = calcProteinsDouble
        }
        currentFoodName = "\(foodHints.food.label)"
        
        foodNameLbl.text = currentFoodName
        proteinsCountLbl.text = ("\(calcProteins) g")
        fatsCountLbl.text = ("\(calcFats) g")
        carbsCountLbl.text = ("\(calcCarbs) g")
        totalCaloriesCountLbl.text = ("\(calcTotalCalories) kcal")
    }
    
    func calcNutriesCount(nutrientType: Float?) ->  String? {
        guard let nutrientType = nutrientType else { return ""}
        
        let energyKcalValue = Double(nutrientType / 100)
        if let quantityTFString = quantityTF.text {
            let quntityValue = Double(quantityTFString) ?? 0
            let resultValue = Double(energyKcalValue * Double(gramsQuantity) * quntityValue)
            let roundedResultDoubleValue = round(10 * resultValue) / 10
            if roundedResultDoubleValue.truncatingRemainder(dividingBy: 1) == 0 {
                currentRoundedResultDoubleValueInt = Int(roundedResultDoubleValue)
                return "\(currentRoundedResultDoubleValueInt)"
            } else {
                currentRoundedResultDoubleValue = roundedResultDoubleValue
                return "\(currentRoundedResultDoubleValue)"
            }
        } else {
            let alert = UIAlertController(title: "", message: "foodHints error", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return nil
        }
    }
}

extension FoodSearchDetailVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == typeQuantityPickerView {
            guard let foodHints = foodHints else { return 0 }
            return foodHints.measures.count
        }
        return Meals.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == typeQuantityPickerView {
            guard let measure = foodHints?.measures[row] else { return }
            gramsQuantity = Int(measure.weight)
            configure()
        } else {
            let mealObject = Meals.allCases[row]
            meal = mealObject.rawValue
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == typeQuantityPickerView {
            guard let foodHints = foodHints else { return "" }
            gramsQuantity = Int(foodHints.measures[row].weight)
            measureType = (foodHints.measures[row].label + " \(gramsQuantity) g")
            return measureType ?? "" + "     􀆏"
        }
        return Meals.allCases[row].rawValue
    }
}

extension FoodSearchDetailVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return textField.text?.count ?? 0 < 8
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        configure()
    }
}

@IBDesignable extension UIPickerView {
    
    @IBInspectable override var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

@IBDesignable extension UITextField {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable override var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}
