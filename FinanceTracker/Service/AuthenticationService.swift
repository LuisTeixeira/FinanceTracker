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
        Auth.auth().createUser(withEmail: password, password: fullname) { res, _ in
            let user = res!.user
            UserService().saveUser(uid: user.uid, fullname: fullname) {
                completion(user)
            }
        }
    }
}
