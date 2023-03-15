//
//  TransactionListUseCase.swift
//  FinanceTracker
//
//  Created by Luís Teixeira on 15.03.23.
//

class ListRecentTransactionsUseCase {
    private let userId: String
    private let transactionService = TransactionService()
    private let accountService = AccountService()
    
    init(withUserId userId: String) {
        self.userId = userId
    }
    
    func listRecentTransactions(completion: @escaping([TransactionViewModel]) -> Void) {
        self.accountService.fetchAccounts(userId: userId) { accounts in
            self.transactionService.fetchTransactions(userId: self.userId, accountId: "", limitTo: 5){ transactions in
                let transactionViewModels = transactions.map { transaction in
                    TransactionViewModel(
                        id: transaction.id!,
                        date: transaction.date,
                        merchant: transaction.merchant,
                        amount: transaction.signedAmount,
                        category: transaction.category,
                        type: transaction.type,
                        isExpense: transaction.isExpense,
                        isTransfer: transaction.isTransfer,
                        accountName: accounts.first{$0.id == transaction.accountId}?.accountName ?? ""
                    )
                }
                completion(transactionViewModels)
            }
        }
    }
}
