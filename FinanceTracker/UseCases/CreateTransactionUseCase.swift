//
//  CreateTransactionUseCase.swift
//  FinanceTracker
//
//  Created by Luís Teixeira on 12.03.23.
//

import Foundation

class CreateTransactionUseCase {
    private let userId: String
    private let transactionService = TransactionService()
    private let accountService = AccountService()
    
    init(withUserId userId: String) {
        self.userId = userId
    }
    
    func createTransaction(forAccount account: Account, transaction: Transaction) {
        var copyAccount = account
        copyAccount.addValue(value: transaction.signedAmount)
        transactionService.addTransaction(userId: userId, transaction: transaction, completion: {
            self.accountService.updateAccount(account: copyAccount){}
        })
    }
}
