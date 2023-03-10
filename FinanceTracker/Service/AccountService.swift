//
//  AccountService.swift
//  FinanceTracker
//
//  Created by Luís Teixeira on 04.03.23.
//

import Firebase
import FirebaseFirestoreSwift
import Collections

struct AccountService {
    func addAccount(userId: String, account: Account, completion: @escaping() -> Void) {
        let data = [
            "accountName": account.accountName,
            "accountName": account.accountValue,
            "userId": userId
        ] as [String : Any]
        
        Firestore.firestore().collection("accounts")
            .addDocument(data: data) { error in
                completion()
            }
    }
    
    func fetchAccounts(userId: String, completion: @escaping([Account]) -> Void) {
        var query = Firestore.firestore()
            .collection("accounts")
            .whereField("userId", isEqualTo: userId)
        
        query.getDocuments { snapshot, error in
            if let error = error {
                print("DEBUG: Error retrieving accounts with error \(error.localizedDescription)")
                return
            }
            guard let documents = snapshot?.documents else {return}
            let accounts = documents.compactMap { try? $0.data(as: Account.self)}
            completion(accounts)
        }
    }
}
