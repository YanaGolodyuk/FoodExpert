//
//  RecipesCollectionVC.swift
//  FoodExpert
//
//  Created by admin on 09.09.2021.
//

import UIKit

class RecipesCollectionVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var recieps: [Recipe] = []
    
    var selectedSegmentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        getReceipt()
    }

    @IBAction func segmentedValueChanged(_ sender: UISegmentedControl) {
        selectedSegmentIndex = sender.selectedSegmentIndex
        let q = searchBar.searchTextField.text ?? ""
        getReceipt(q: q)
    }
    
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return recieps.count
    }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReciepeImageCell", for: indexPath) as? ReciepeImageCell {
            cell.configure(receip: recieps[indexPath.row])
            return cell
        }
    
        // Configure the cell
    
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let receipt = recieps[indexPath.row]
        
        let vc = UIStoryboard(name: <#T##String#>, bundle: <#T##Bundle?#>)
        //TODO: - тут переход на следуюзий экран пишешь. внутрь следующего экрана положи receipt, и из него на следующем экране доставай всю нужную тебе инфук
    }
}

extension RecipesCollectionVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
            let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
            let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
            return CGSize(width: size, height: size)
        }
}


extension RecipesCollectionVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if(!(searchBar.text?.isEmpty)!){
            //reload your data source if necessary
            self.collectionView?.reloadData()
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        getReceipt(q: searchText)
    }
    
    func getReceipt(q: String = "") {
        
        var mealType = "Breakfast"
        
        switch selectedSegmentIndex {
        case 0:
            mealType = "Breakfast"
        case 1:
            mealType = "Lunch"
        default:
            mealType = "Dinner"
        }
        
        ServerManager.shared.getRceipts(q: q, mealType: mealType, completion: { recieps in
            
            self.recieps = recieps
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
    }
}
