//
//  AddFoodTVC.swift
//  FoodExpert
//
//  Created by admin on 09.09.2021.
//

import UIKit

class AddFoodTVC: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var foodHints: [FoodHint] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.searchTextField.textColor = UIColor.white
        getFood()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodHints.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let food = foodHints[indexPath.row].food

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let vc = UIStoryboard(name: "FoodSearchDetail", bundle: nil).instantiateInitialViewController() as? FoodSearchDetailVC {
//            vc.food = food[indexPath.row]
//            navigationController?.pushViewController(vc, animated: true)
//        }
    }
}

extension AddFoodTVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if(!(searchBar.text?.isEmpty)!){
            //reload your data source if necessary
            self.tableView?.reloadData()
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        getFood(ingr: searchText)
    }
    
    func getFood(ingr: String = "") {
        ServerManager.shared.getFood(ingr: ingr) { foodHints in
            self.foodHints = foodHints
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
