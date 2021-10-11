import UIKit
import SwiftUI
import CoreData

class MealsDetailTVC: UITableViewController {
    
    var meal: Meals?
    var measureType: String?
    
    var meals: [Meal] { CoreDataManger.shared.getMeals(by: meal) ?? [] }
    
    @IBOutlet weak var mealTypeLbl: UILabel!
    
    @IBAction func addFoodBtnTapped(_ sender: UIButton) {
        if let vc = UIStoryboard(name: "AddFoodStoryboard", bundle: nil).instantiateViewController(withIdentifier: "AddFoodTVC") as? AddFoodTVC {
            vc.meal = mealTypeLbl.text
            navigationController?.pushViewController(vc, animated: true)
        }
//        tabBarController?.selectedIndex = 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: NSNotification.Name.init(rawValue: "mealAdded"), object: nil)
    
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        title = meal?.rawValue
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        mealTypeLbl.text = meal?.rawValue
       
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func reloadTableView() {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FoodTVCell
        cell.configure(by: meals[indexPath.row - 1])
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CoreDataManger.shared.delete(meal: meals[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
