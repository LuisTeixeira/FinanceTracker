//
//  ContentView.swift
//  FinanceTracker
//
//  Created by Luís Teixeira on 28.01.23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = RecentTransactionsViewModel()
    @State private var isAddingNewTransaction = false
    @State private var newTransaction = Transaction()
    
    var body: some View {
        NavigationView {
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
                                        TransactionService().addTransaction(transaction: newTransaction) {
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
        .navigationViewStyle(.stack)
        .accentColor(.primary)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
