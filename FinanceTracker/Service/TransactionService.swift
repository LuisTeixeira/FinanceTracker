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
    
    func fetchTransactions(limitTo: Int, completion: @escaping([Transaction]) -> Void) {
        var query = Firestore.firestore()
            .collection("transactions")
            .order(by: "date", descending: true)
        
        query = (limitTo > 0) ? query.limit(to: limitTo) : query
        
        query.getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else {return}
                let transations = documents.compactMap { try? $0.data(as: Transaction.self) }
                completion(transations)
            }
    }
    
    func fetchCurrentMonthTransactions(limit: Int, completion: @escaping([Transaction]) -> Void) {
        let start = Date.now.beginOfCurrentMonth
        let end = Date.now.beginOfNextMonth
        
        var query = Firestore.firestore()
            .collection("transactions")
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
    
    func addTransaction(transaction: Transaction, completion: @escaping() -> Void) {
        let data = [
            "account": transaction.account,
            "amount": transaction.amount,
            "category": transaction.category,
            "date": transaction.date,
            "isExpense": transaction.isExpense,
            "isTransfer": transaction.isTransfer,
            "merchant": transaction.merchant,
            "type": transaction.type
        ] as [String : Any]
        
        Firestore.firestore().collection("transactions")
            .addDocument(data: data) { error in
                completion()
            }
    }
    
}
