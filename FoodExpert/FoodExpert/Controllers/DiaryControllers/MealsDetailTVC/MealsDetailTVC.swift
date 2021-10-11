//
//  MealsDetailTVC.swift
//  FoodExpert
//
//  Created by admin on 30.09.2021.
//

import UIKit
import SwiftUI

class MealsDetailTVC: UITableViewController {
    
    var meal: Meals?
    
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
        navigationController?.setNavigationBarHidden(false, animated: false)
        title = meal?.rawValue
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        mealTypeLbl.text = meal?.rawValue
       
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FoodTVCell
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
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
