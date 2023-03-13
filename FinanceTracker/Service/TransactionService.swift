//
//  TransactionService.swift
//  FinanceTracker
//
//  Created by Luís Teixeira on 29.01.23.
//

import Firebase
import FirebaseFirestoreSwift
import Collections

struct TransactionService {
    
    func fetchTransactions(userId: String, accountId: String, limitTo: Int, completion: @escaping([Transaction]) -> Void) {
        var query = Firestore.firestore()
            .collection("transactions")
            .whereField("userId", isEqualTo: userId)
            .order(by: "date", descending: true)
        
        query = (limitTo > 0) ? query.limit(to: limitTo) : query
        query = (!accountId.isEmpty) ? query.whereField("accountId", isEqualTo: accountId) : query
        
        query.getDocuments { snapshot, error in
            if let error = error {
                print("DEBUG: Failed to sing in with error \(error.localizedDescription)")
                return
            }
            guard let documents = snapshot?.documents else {return}
            let transations = documents.compactMap { try? $0.data(as: Transaction.self) }
            completion(transations)
        }
    }
    
    func fetchCurrentMonthTransactions(userId: String, limit: Int, completion: @escaping([Transaction]) -> Void) {
        let start = Date.now.beginOfCurrentMonth
        let end = Date.now.beginOfNextMonth
        
        var query = Firestore.firestore()
            .collection("transactions")
            .whereField("userId", isEqualTo: userId)
            .whereField("date", isGreaterThan: start)
            .whereField("date", isLessThan: end)
            .order(by: "date", descending: true)
        
        query = (limit > 0) ? query.limit(to: limit) : query
            
        query.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else {return}
            let transations = documents.compactMap { try? $0.data(as: Transaction.self) }
            completion(transations)
        }
    }
    
    func addTransaction(userId: String, transaction: Transaction, completion: @escaping() -> Void) {
        let data = [
            "accountId": transaction.accountId,
            "amount": transaction.amount,
            "category": transaction.category,
            "date": transaction.date,
            "isExpense": transaction.isExpense,
            "isTransfer": transaction.isTransfer,
            "merchant": transaction.merchant,
            "type": transaction.type,
            "userId": userId
        ] as [String : Any]
        
        Firestore.firestore().collection("transactions")
            .addDocument(data: data) { error in
                completion()
            }
    }
    
}
