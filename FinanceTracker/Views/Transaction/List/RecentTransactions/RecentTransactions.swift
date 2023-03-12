//
//  RecentTransactions.swift
//  FinanceTracker
//
//  Created by Luís Teixeira on 30.01.23.
//

import SwiftUI

struct RecentTransactions: View {
    @ObservedObject var viewModel: RecentTransactionsViewModel
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Recent Transactions")
                    .bold()
                
                Spacer()
                
                NavigationLink {
                    //TransactionList(withUserId: self.authenticationViewModel.userSession!.uid)
                } label: {
                    HStack(spacing: 4) {
                        Text("See All")
                        Image(systemName: "chevron.right")
                    }
                }
            }
            .padding(.top)
            
            ForEach(viewModel.transactions, id: \.id) { transaction in
                TransactionView(transaction: transaction)
                Divider()
            }
        }
        .padding()
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y: 5)
    }
}


