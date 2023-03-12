//
//  RecentTransactionsViewModel.swift
//  FinanceTracker
//
//  Created by Luís Teixeira on 30.01.23.
//

import Foundation

class RecentTransactionsViewModel : ObservableObject {
    var userId: String
    @Published var transactions = [Transaction]()
    
    let service = TransactionService()
    
    init(widthUserId userId: String) {
        self.userId = userId
        fetchRecentTransactions()
    }
    
    func fetchRecentTransactions() {
        service.fetchTransactions(userId: userId, accountId: "", limitTo: 3) { transactions in
            self.transactions = transactions
        }
    }
    
}
