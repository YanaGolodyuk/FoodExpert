import UIKit

class FoodDiaryVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var meals: [Meals] = Meals.allCases
    
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
    
    @IBOutlet weak var mealsTableView: UITableView!
    
    @IBAction func addButtonAction(_ sender: UIButton) {
        if let vc = UIStoryboard(name: "DiaryMainStoryboard", bundle: nil).instantiateViewController(withIdentifier: "AddFoodTVC") as? AddFoodTVC {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //    var genaPidor: Bool = true
//    var pidory: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mealsTableView.delegate = self
        mealsTableView.dataSource = self
        
//        let id = UUID().uuidString
//        print(genaPidor)
//        print(pidory)
//        print("ended")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
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
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
//    {
//        return 50 //or whatever you need
//    }
    
}
