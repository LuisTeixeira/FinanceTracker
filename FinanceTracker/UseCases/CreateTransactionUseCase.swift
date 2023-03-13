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
    
    func createTransaction(forAccount account: Account, transaction: Transaction, completion: @escaping() -> Void) {
        var copyAccount = account
        var copyTransaction = transaction
        copyTransaction.accountId = account.id!
        copyAccount.addValue(value: transaction.signedAmount)
        transactionService.addTransaction(userId: userId, transaction: copyTransaction, completion: {
            self.accountService.updateAccount(account: copyAccount){}
            completion()
        })
    }
}
