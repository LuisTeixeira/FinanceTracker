//
//  AccountsCard.swift
//  FinanceTracker
//
//  Created by Luís Teixeira on 15.03.23.
//

import SwiftUI

struct AccountsCard: View {
    var userId: String
    
    var body: some View {
        VStack {
            HStack {
                Text("Accounts")
                    .bold()
                
                Spacer()
                
                NavigationLink {
                    AccountListPage(withUserId: userId)
                } label: {
                    HStack(spacing: 4) {
                        Text("See All")
                        Image(systemName: "chevron.right")
                    }
                }
            }
            .padding(.top)
            
            AccountListView(withUserId: userId)
        }
        .padding()
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y: 5)
    }
}
