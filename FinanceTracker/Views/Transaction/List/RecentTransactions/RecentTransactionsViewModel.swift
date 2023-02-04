//
//  RecentTransactionsViewModel.swift
//  FinanceTracker
//
//  Created by Luís Teixeira on 30.01.23.
//

import Foundation

class RecentTransactionsViewModel : ObservableObject {
    @Published var transactions = [Transaction]()
    
    let service = TransactionService()
    
    init() {
        fetchRecentTransactions()
    }
    
    func fetchRecentTransactions() {
        service.fetchTransactions(limitTo: 3) { transactions in
            self.transactions = transactions
        }
    }
    
}
