//
//  TransactionList.swift
//  FinanceTracker
//
//  Created by Luís Teixeira on 30.01.23.
//

import SwiftUI

struct TransactionList: View {
    @ObservedObject var viewModel = TransactionsViewModel()
    
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
    }
}

struct TransactionList_Previews: PreviewProvider {
    static var previews: some View {
        TransactionList()
    }
}
