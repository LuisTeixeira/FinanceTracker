//
//  AccountListView.swift
//  FinanceTracker
//
//  Created by Luís Teixeira on 15.03.23.
//

import SwiftUI

struct AccountListView: View {
    var userId: String
    @ObservedObject var viewModel: AccountListViewModel
    
    init(withUserId userId: String) {
        self.userId = userId
        self.viewModel = AccountListViewModel(withUserId: userId)
    }
    
    var body: some View {
        VStack {
            ForEach(viewModel.accounts, id: \.id) { account in
                NavigationLink{
                    TransactionList(withUserId: userId, account: account)
                } label: {
                    AccountRowView(account: account)
                }
                .buttonStyle(.plain)
            }
        }
        .onAppear {
            viewModel.fetchAccounts()
        }
    }
}
