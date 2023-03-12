//
//  TransactionList.swift
//  FinanceTracker
//
//  Created by Luís Teixeira on 30.01.23.
//

import SwiftUI

struct TransactionList: View {
    var userId: String
    var account: Account
    @ObservedObject var viewModel: TransactionsViewModel
    
    init(withUserId userId: String, account: Account) {
        self.userId = userId
        self.account = account
        self.viewModel = TransactionsViewModel(widthUserId: self.userId, accountId: account.id!)
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.transactions, id: \.id) { transaction in
                    TransactionView(transaction: transaction)
                }
            }
        }
        .navigationTitle("Transactions")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.background)
    }
}
