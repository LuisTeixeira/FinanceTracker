//
//  TransactionList.swift
//  FinanceTracker
//
//  Created by Luís Teixeira on 30.01.23.
//

import SwiftUI

struct TransactionList: View {
    var userId: String
    @ObservedObject var viewModel: TransactionsViewModel
    
    init(withUserId userId: String) {
        self.userId = userId
        self.viewModel = TransactionsViewModel(widthUserId: self.userId)
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
