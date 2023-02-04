//
//  Overview.swift
//  FinanceTracker
//
//  Created by Luís Teixeira on 04.02.23.
//

import SwiftUI

struct Overview: View {
    var userId: String
    @ObservedObject var viewModel: RecentTransactionsViewModel
    @State private var isAddingNewTransaction = false
    @State private var newTransaction = Transaction()
    
    init(withUserId userId: String) {
        self.userId = userId
        viewModel = RecentTransactionsViewModel(widthUserId: userId)
    }
    
    var body: some View {
        ScrollView {
            VStack{
                RecentTransactions(viewModel: viewModel)
            }
            .navigationTitle("Overview")
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
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancel") {
                                    isAddingNewTransaction = false
                                }
                            }
                            ToolbarItem {
                                Button {
                                    TransactionService().addTransaction(userId: userId, transaction: newTransaction) {
                                        viewModel.fetchRecentTransactions()
                                        isAddingNewTransaction = false
                                    }
                                } label: {
                                    Text("Add")
                                }
                            }
                        }
                }
            }
        }
        .background(Color(.systemFill))

    }
}
