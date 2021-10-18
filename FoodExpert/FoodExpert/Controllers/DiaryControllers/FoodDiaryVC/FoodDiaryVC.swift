import UIKit
import CoreData

class FoodDiaryVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var meals: [Meals] = Meals.allCases
    var userName: String = ""
    var notes = [Note]()
    var mealsFromCurrentDate: [Meal] {
        return CoreDataManger.shared.currentNote?.meals?.allObjects as? [Meal] ?? []
    }
    
    @IBOutlet weak var mealPlanLabel: UILabel!
    
    @IBOutlet weak var kcalLeftProgressView: UIProgressView!
    
    @IBOutlet weak var intakeKcalLabel: UILabel!
    @IBOutlet weak var kcalLeftLabel: UILabel!
    @IBOutlet weak var outtakeKcalLabel: UILabel!
    
    @IBOutlet weak var carbsIntakeLabel: UILabel!
    @IBOutlet weak var carbsIntakeProgressView: UIProgressView!
    
    @IBOutlet weak var proteinsIntakeLabel: UILabel!
    @IBOutlet weak var proteinsIntakeProgressView: UIProgressView!
    
    @IBOutlet weak var fatsIntakeLabel: UILabel!
    @IBOutlet weak var fatsIntakeProgressView: UIProgressView!
    
    @IBOutlet weak var showPreviousDayBtn: UIButton!
    @IBOutlet weak var dateSetBtn: UIButton!
    @IBOutlet weak var showNextDayBtn: UIButton!
    
    @IBOutlet weak var mealsTableView: UITableView!
    
//    @IBAction func addButtonAction(_ sender: UIButton) {
//        if let vc = UIStoryboard(name: "AddFoodStoryboard", bundle: nil).instantiateViewController(withIdentifier: "AddFoodTVC") as? AddFoodTVC {
//            navigationController?.pushViewController(vc, animated: true)
//        }
//    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        dateSetBtn.setTitle(Date().toString(), for: .normal)
        mealsTableView.delegate = self
        mealsTableView.dataSource = self
        navigationController?.navigationBar.isHidden = true
        configure()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateNote), name: NSNotification.Name.init(rawValue: "dateChanged"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func updateNote() {
        let date = CoreDataManger.shared.currentSelectedDate ?? Date()
        dateSetBtn.setTitle(date.toString(), for: .normal)
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        configure()
    }
    
    func configure() {
        intakeKcalLabel.text = "\(Int(mealsFromCurrentDate.caloriesSum))"
        proteinsIntakeLabel.text = "\(Int(mealsFromCurrentDate.proteinsSum))"
        carbsIntakeLabel.text = "\(Int(mealsFromCurrentDate.carbsSum))"
        fatsIntakeLabel.text = "\(Int(mealsFromCurrentDate.fatsSum))"
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MealTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MealTableViewCell

        let meal = meals[indexPath.row]
        cell.mealLabel.text = meal.rawValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = UIStoryboard(name: "MealsDetailStoryboard", bundle: nil).instantiateInitialViewController() as? MealsDetailTVC {
            vc.meal = meals[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

@IBDesignable extension UIView {

    @IBInspectable var borderColor: UIColor? {
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

extension Array where Element: Meal {
    var caloriesSum: Int {
        return self.map({ Int($0.calories) }).reduce(0, +)
    }
    var proteinsSum: Double {
        return self.map({ $0.proteins }).reduce(0, +)
    }
    var carbsSum: Double {
        return self.map({ $0.carbs }).reduce(0, +)
    }
    var fatsSum: Double {
        return self.map({ $0.fats }).reduce(0, +)
    }
}
