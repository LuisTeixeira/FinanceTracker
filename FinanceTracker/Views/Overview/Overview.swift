//
//  Overview.swift
//  FinanceTracker
//
//  Created by Luís Teixeira on 04.02.23.
//

import SwiftUI

struct Overview: View {
    var userId: String
    @ObservedObject var recentTransactionsViewModel: RecentTransactionsViewModel
    @ObservedObject var recentChartViewModel: RecentChartViewModel
    @State private var isAddingNewTransaction = false
    @State private var newTransaction = Transaction()
        
    init(withUserId userId: String) {
        self.userId = userId
        recentTransactionsViewModel = RecentTransactionsViewModel(widthUserId: userId)
        recentChartViewModel = RecentChartViewModel(withUserId: userId)
    }
    
    var body: some View {
        ScrollView {
            VStack{
                RecentChart(viewModel: recentChartViewModel).frame(height: 200).padding()
                RecentTransactions(viewModel: recentTransactionsViewModel).padding()
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
                                        recentTransactionsViewModel.fetchRecentTransactions()
                                        recentChartViewModel.getGraphData()
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
        .background(Color.background)

    }
}
