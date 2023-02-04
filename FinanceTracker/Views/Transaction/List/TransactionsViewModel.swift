//
//  TransactionsViewModel.swift
//  FinanceTracker
//
//  Created by Luís Teixeira on 28.01.23.
//

import Foundation

class TransactionsViewModel: ObservableObject {
    var userId: String
    @Published var transactions = [Transaction]()
    
    let service = TransactionService()
    
    init(widthUserId userId: String) {
        self.userId = userId
        fetchTransactions()
    }
    
    func fetchTransactions() {
        service.fetchTransactions(userId: userId, limitTo: 0) { transactions in
            self.transactions = transactions
        }

    }
}
