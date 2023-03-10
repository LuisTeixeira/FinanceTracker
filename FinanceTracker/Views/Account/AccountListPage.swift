//
//  AccountListView.swift
//  FinanceTracker
//
//  Created by Luís Teixeira on 03.03.23.
//

import SwiftUI

struct AccountListPage: View {
    var userId: String
    @State private var isAddingNewAccount = false
    @State private var newAccount = Account()
    
    init(withUserId userId: String) {
        self.userId = userId
    }
    
    var body: some View {
        VStack{
            List {
                AccountListView(withUserId: userId)
            }
        }
        .navigationTitle("Accounts")
        .toolbar {
            ToolbarItem {
                Button {
                    newAccount = Account()
                    isAddingNewAccount = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.background)
        .sheet(isPresented: $isAddingNewAccount) {
            NavigationStack {
                AccountEditor(account: $newAccount)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isAddingNewAccount = false
                            }
                        }
                        ToolbarItem {
                            Button {
                                AccountService().addAccount(userId: userId, account: newAccount) {
                                    isAddingNewAccount = false
                                }
                            } label: {
                                Text("Add")
                            }
                        }
                    }
            }
        }
    }
}

