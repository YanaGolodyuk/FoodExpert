//
//  FirebaseAuthManager.swift
//  FoodExpert
//
//  Created by admin on 29.09.2021.
//

import FirebaseAuth
import Firebase
import UIKit

class FirebaseAuthManager {
    
    var ref: DatabaseReference!
    
    func signIn(with email: String, password: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            /*
             Условие (authResult?.user != nil) равносильно флагу true / false и значение, которое вернет условие
             будет возвращено в completionBlock
             */
            completionBlock(authResult?.user != nil)
        }
    }

    func createUser(email: String, password: String, completionBlock: @escaping (_ success: Bool, _ localizedError: String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                completionBlock(false, error.localizedDescription)
            } else {
                guard (authResult?.user) != nil else { return }
                let userRef = self?.ref.child((authResult?.user.uid)!)
                userRef?.setValue(["email": authResult?.user.email])
                completionBlock(true, nil)
            }
        }
    }
}
