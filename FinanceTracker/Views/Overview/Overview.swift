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
    @ObservedObject var transactionGraphViewModel: TransactionGraphViewModel
    @State private var isAddingNewTransaction = false
    @State private var newTransaction = Transaction()
    
    private let entries: [GraphEntry]
    
    init(withUserId userId: String) {
        self.userId = userId
        recentTransactionsViewModel = RecentTransactionsViewModel(widthUserId: userId)
        transactionGraphViewModel = TransactionGraphViewModel(withUserId: userId)
        
        // Test swift chart
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        self.entries = [
            GraphEntry(date: dateFormatter.date(from: "29/01/2023")!, value: -23.4),
            GraphEntry(date: dateFormatter.date(from: "30/01/2023")!, value: -343.99),
            GraphEntry(date: dateFormatter.date(from: "31/01/2023")!, value: 2345.0)
        ]
    }
    
    var body: some View {
        ScrollView {
            VStack{
                RecentChart(entries: self.entries)
                LastTransactionsGraph(viewModel: transactionGraphViewModel)
                RecentTransactions(viewModel: recentTransactionsViewModel)
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
                                        transactionGraphViewModel.getGraphData()
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
