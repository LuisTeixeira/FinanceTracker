//
//  TransactionGraphViewModel.swift
//  FinanceTracker
//
//  Created by Luís Teixeira on 06.02.23.
//

import Foundation

typealias TransactionGraphData = [(String, Double)]

class TransactionGraphViewModel: ObservableObject {
    @Published var graphData = TransactionGraphData()
    var userId: String
    
    init(withUserId userId: String) {
        self.userId = userId
        getGraphData()
    }
    
    func getGraphData() {
        TransactionService().fetchTransactions(userId: userId, limitTo: 10) { transactions in
            var tmpGraphData = TransactionGraphData()
            for date in stride(from: transactions.last?.date ?? Date.now, through: Date.now, by: 60 * 60 * 24) {
                
                let dailyExpenses = transactions.filter {self.isTheSameDate(first: $0.date, second: date)}
                var dailyTotal = dailyExpenses.reduce(0) { $0 + $1.signedAmount}
                
                dailyTotal = (dailyTotal * 100).rounded() / 100
                
                if !dailyExpenses.isEmpty {
                    tmpGraphData.append((date.formatted(.dateTime.day().month(.twoDigits).year()), dailyTotal))
                }
            }
            self.graphData = tmpGraphData
        }
    }
    
    private func isTheSameDate(first: Date, second: Date) -> Bool {
        var calendar = Calendar.current
        return calendar.isDate(first, equalTo: second, toGranularity:.day)
    }
}
