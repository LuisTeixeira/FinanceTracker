//
//  AccountListViewModel.swift
//  FinanceTracker
//
//  Created by Luís Teixeira on 03.03.23.
//

import Foundation

class AccountListViewModel : ObservableObject {
    var userId: String
    @Published var accounts = [Account]()
    
    let service = AccountService()
    
    init(withUserId userId: String) {
        self.userId = userId
        fetchAccounts()
    }
    
    func fetchAccounts() {
        service.fetchAccounts(userId: self.userId) { accounts in
            self.accounts = accounts
        }
    }
}
