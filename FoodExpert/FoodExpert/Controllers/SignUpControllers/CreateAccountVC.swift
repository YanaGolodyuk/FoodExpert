//
//  CreateAccountVC.swift
//  FoodExpert
//
//  Created by admin on 08.09.2021.
//

import UIKit
import Firebase

class CreateAccountVC: UIViewController {
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference(withPath: "users")
    
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let _ = user else { return }
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
    
    @IBAction func SignUpBtnTapped(_ sender: Any) {
        guard let name = nameTF.text, name != "",
              let email = emailTF.text, email != "",
              let password = passTF.text, password != ""  else { return }
        didTapSignUpButton(email, password)
    }
    
    func didTapSignUpButton(_ email: String, _ password: String) {
        FirebaseAuthManager().createUser(email: email, password: password) { [weak self] success, errorString  in
            guard let self = self else { return }
            switch success {
            case true :
                if let foodDiaryVC = UIStoryboard(name: "DiaryMainStoryboard", bundle: .main).instantiateInitialViewController() {
                    self.navigationController?.show(foodDiaryVC, sender: nil)
                }
            case false:
                let alertController = UIAlertController(title: nil, message: "Registration was incorrect\n\(errorString ?? "")", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    

}
