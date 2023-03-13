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
    @State private var newTransaction = Transaction()
    @State private var isAddingNewTransaction = false
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
        .toolbar {
            ToolbarItem {
                Button {
                    newTransaction = Transaction()
                    isAddingNewTransaction = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isAddingNewTransaction) {
            NavigationStack {
                TransactionEditor(transaction: $newTransaction)
                    .toolbar{
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isAddingNewTransaction = false
                            }
                        }
                        ToolbarItem {
                            Button {
                                CreateTransactionUseCase(withUserId: userId).createTransaction(forAccount: account, transaction: newTransaction) {
                                    viewModel.fetchTransactions()
                                    isAddingNewTransaction = false
                                }
                            } label: {
                                Text("Add")
                            }
                        }
                    }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.background)
    }
}
