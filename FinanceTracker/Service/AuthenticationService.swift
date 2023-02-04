//
//  AuthenticationService.swift
//  FinanceTracker
//
//  Created by Luís Teixeira on 03.02.23.
//

import FirebaseAuth
import Firebase

class AuthenticationService {
    
    func currentUser() -> User? {
        return Auth.auth().currentUser
    }
    
    func register(withEmail email: String, password: String, fullname: String, completion: @escaping(FirebaseAuth.User) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { res, error in
            if let error = error {
                print("DEBUG: Email: \(email)")
                print("DEBUG: Failed to sing in with error \(error.localizedDescription)")
                return
            }
            
            let user = res!.user
            UserService().saveUser(uid: user.uid, fullname: fullname) {
                completion(user)
            }
        }
    }
    
    func login(withEmail email: String, password: String, completion: @escaping(FirebaseAuth.User) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { res, error in
            if let error = error {
                print("DEBUG: Failed to sing in with error \(error.localizedDescription)")
                return
            }
            let user = res!.user
            completion(user)
        }
    }
}
