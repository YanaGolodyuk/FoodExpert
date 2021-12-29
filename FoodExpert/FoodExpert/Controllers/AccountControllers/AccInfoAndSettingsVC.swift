import UIKit
import Firebase

class AccInfoAndSettingsVC: UIViewController {

    @IBOutlet weak var accountImage: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var mealPlanLlb: UILabel!
    
    @IBAction func logOutButtonTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
            } catch let err {
                print(err)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameLbl.text = CoreDataManger.shared.currentUser?.name
    }
}
