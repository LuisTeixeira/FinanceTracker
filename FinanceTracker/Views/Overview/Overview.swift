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
        
    init(withUserId userId: String) {
        self.userId = userId
        recentTransactionsViewModel = RecentTransactionsViewModel(widthUserId: userId)
        recentChartViewModel = RecentChartViewModel(withUserId: userId)
    }
    
    var body: some View {
        ScrollView {
            VStack{
                AccountsCard(userId: userId).padding()
                RecentChart(viewModel: recentChartViewModel).padding()
                RecentTransactions(viewModel: recentTransactionsViewModel).padding()
            }
            .navigationTitle("Overview")
        }
        .background(Color.background)

    }
}
