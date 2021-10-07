import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var userErrorLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        userErrorLbl.isHidden = true
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        emailTF.text = ""
//        passTF.text = ""
//    }

    @IBAction func signInTapped() {
        guard
            let email = emailTF.text, !email.isEmpty,
            let password = passTF.text, !password.isEmpty
        else {
            userErrorLbl.isHidden = false
            return
        }
        
        userErrorLbl.isHidden = true
        checkUser(email, password)
    }
    
    private func checkUser(_ email: String, _ password: String) {
        activityIndicatorView.startAnimating()
        FirebaseAuthManager().signIn(with: email, password: password) { [weak self] success in
            guard let self = self else { return }
            self.activityIndicatorView.stopAnimating()
            switch success {
            case true :
                if let foodDiaryVC = UIStoryboard(name: "DiaryMainStoryboard", bundle: .main).instantiateInitialViewController() {
                    foodDiaryVC.modalPresentationStyle = .fullScreen
                    self.present(foodDiaryVC, animated: false, completion: nil)
                }

            case false:
                let alertController = UIAlertController(title: "Error!", message: "No acount we're found", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
}
