import UIKit

class AddFoodTVC: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var foodHints: [FoodHint] = []
    var meal: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.searchTextField.textColor = UIColor.white
        title = "Search food"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        getFood(ingr: "a")
        getFood()
        self.hideKeyboardWhenTappedAround()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodHints.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AddFoodTVCell", for: indexPath) as? AddFoodTVCell {
            if foodHints.count > indexPath.row {
            cell.configure(food: foodHints[indexPath.row].food)
            }
            return cell
        }
        return UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = UIStoryboard(name: "FoodSearchDetail", bundle: nil).instantiateInitialViewController() as? FoodSearchDetailVC {
            vc.foodHints = foodHints[indexPath.row]
            vc.meal = meal
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(false)
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.getFood(ingr: searchText)
        }
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
