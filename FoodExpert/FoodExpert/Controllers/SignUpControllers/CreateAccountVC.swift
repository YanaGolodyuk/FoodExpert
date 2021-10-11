import UIKit
import Firebase

class CreateAccountVC: UIViewController {
    
    var ref: DatabaseReference!
    
    var userName: String?
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passTF: UITextField!
    //    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference(withPath: "users")
        
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let _ = user else { return }
        }
    }
    
    @IBAction func SignUpBtnTapped(_ sender: Any) {
        guard let name = nameTF.text, name != "",
              let email = emailTF.text, email != "",
              let password = passTF.text, password != ""  else { return }
        
        userName = name
        didTapSignUpButton(email, password)
    }
    
    func didTapSignUpButton(_ email: String, _ password: String) {
        FirebaseAuthManager().createUser(email: email, password: password) { [weak self] success, errorString  in
            guard let self = self else { return }
            switch success {
            case true :
                CoreDataManger.shared.authorize(with: email)
                
                if let foodDiaryVC = UIStoryboard(name: "DiaryMainStoryboard", bundle: .main).instantiateInitialViewController() {
                    self.navigationController?.show(foodDiaryVC, sender: nil)
                    self.dismiss(animated: true, completion: nil)
                }
            case false:
                let alertController = UIAlertController(title: nil, message: "Registration was incorrect\n\(errorString ?? "")", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
}
