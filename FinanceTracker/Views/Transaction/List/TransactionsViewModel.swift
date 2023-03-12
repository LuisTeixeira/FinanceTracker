//
//  TransactionsViewModel.swift
//  FinanceTracker
//
//  Created by Luís Teixeira on 28.01.23.
//

import Foundation

class TransactionsViewModel: ObservableObject {
    var userId: String
    var accountId: String
    @Published var transactions = [Transaction]()
    
    let service = TransactionService()
    
    init(widthUserId userId: String, accountId: String) {
        self.userId = userId
        self.accountId = accountId
        fetchTransactions()
    }
    
    func fetchTransactions() {
        service.fetchTransactions(userId: userId, accountId: accountId, limitTo: 0) { transactions in
            self.transactions = transactions
        }

    }
}
