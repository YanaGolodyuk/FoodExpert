//
//  FoodSearchDetailVC.swift
//  FoodExpert
//
//  Created by admin on 06.10.2021.
//

import UIKit

class FoodSearchDetailVC: UIViewController {

    var foodHints: FoodHint?
    var meal: String?
    
    @IBOutlet weak var foodNameLbl: UILabel!
    
    @IBOutlet weak var quantityTF: UITextField!
    @IBOutlet weak var typeQuantityPickerView: UIPickerView!
    @IBOutlet weak var totalCaloriesCountLbl: UILabel!
    @IBOutlet weak var mealPickerView: UIPickerView!
    
    @IBOutlet weak var proteinsCountLbl: UILabel!
    @IBOutlet weak var fatsCountLbl: UILabel!
    @IBOutlet weak var carbsCountLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        typeQuantityPickerView.dataSource = self
        typeQuantityPickerView.delegate = self
        mealPickerView.dataSource = self
        mealPickerView.delegate = self
//        mealPickerView.selectRow(inbdex, inComponent: 0, animated: false)
       configure()
    }
    
    func configure() {
        guard let foodHints = foodHints else { return }
        foodNameLbl.text = foodHints.food.label
        proteinsCountLbl.text = "\(Int(foodHints.food.nutrients.PROCNT))"
        fatsCountLbl.text = "\(Int(foodHints.food.nutrients.FAT))"
        carbsCountLbl.text = "\(Int(foodHints.food.nutrients.CHOCDF))"
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
            let typeQuantity = foodHints?.measures[row].label
        } else {
            let mealSet = Meals.allCases[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == typeQuantityPickerView {
            guard let foodHints = foodHints else { return "" }
            return foodHints.measures[row].label
        }
        return Meals.allCases[row].rawValue
    }
}
