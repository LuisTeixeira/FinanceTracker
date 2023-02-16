//
//  RecentChartViewModel.swift
//  FinanceTracker
//
//  Created by Luís Teixeira on 16.02.23.
//

import Foundation

class RecentChartViewModel: ObservableObject {
    @Published var graphEntries: [GraphEntry]
    var userId: String
    
    init(withUserId userId: String) {
        self.userId = userId
        self.graphEntries = []
        self.getGraphData()
    }
    
    func getGraphData() {
        TransactionService().fetchTransactions(userId: userId, limitTo: 10) { transactions in
            
            for date in stride(from: transactions.last?.date ?? Date.now, through: Date.now, by: 60 * 60 * 24) {
                
                let dailyExpenses = transactions.filter {self.isTheSameDate(first: $0.date, second: date)}
                var dailyTotal = dailyExpenses.reduce(0) { $0 + $1.signedAmount}
                
                dailyTotal = (dailyTotal * 100).rounded() / 100
                
                if !dailyExpenses.isEmpty {
                    self.graphEntries.append(GraphEntry(date: date, value: dailyTotal))
                }
            }
        }
    }
    
    private func isTheSameDate(first: Date, second: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(first, equalTo: second, toGranularity:.day)
    }
}

struct GraphEntry {
    var date: Date
    var value: Double
    var animate = false
}
