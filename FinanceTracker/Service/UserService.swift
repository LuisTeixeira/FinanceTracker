//
//  UserService.swift
//  FinanceTracker
//
//  Created by Luís Teixeira on 03.02.23.
//

import Foundation
import Firebase

class UserService {
    
    func saveUser(uid: String, fullname: String, completion: @escaping() -> Void) {
        let data = [
            "fullname": fullname
        ]
        Firestore.firestore().collection("users")
            .document(uid)
            .setData(data) { _ in
                completion()
            }
    }
}
