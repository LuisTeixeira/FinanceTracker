//
//  TransactionsViewModel.swift
//  FinanceTracker
//
//  Created by Luís Teixeira on 28.01.23.
//

import Foundation

class TransactionsViewModel: ObservableObject {
    @Published var transactions = [Transaction]()
    
    let service = TransactionService()
    init() {
        fetchTransactions()
    }
    
    func fetchTransactions() {
        service.fetchTransactions(limitTo: 0) { transactions in
            self.transactions = transactions
        }

    }
}
