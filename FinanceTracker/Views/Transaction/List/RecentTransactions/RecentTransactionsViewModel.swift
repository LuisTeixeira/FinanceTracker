//
//  RecentTransactionsViewModel.swift
//  FinanceTracker
//
//  Created by Luís Teixeira on 30.01.23.
//

import Foundation

class RecentTransactionsViewModel : ObservableObject {
    var userId: String
    @Published var transactions = [TransactionViewModel]()
    
    var useCase: ListRecentTransactionsUseCase
    
    init(widthUserId userId: String) {
        self.userId = userId
        self.useCase = ListRecentTransactionsUseCase(withUserId: userId)
        fetchRecentTransactions()
    }
    
    func fetchRecentTransactions() {
        useCase.listRecentTransactions { transactions in
            self.transactions = transactions
        }
    }
    
}
