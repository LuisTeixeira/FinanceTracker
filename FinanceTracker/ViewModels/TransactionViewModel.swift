//
//  TransactionViewModel.swift
//  FinanceTracker
//
//  Created by Luís Teixeira on 15.03.23.
//

import Foundation

struct TransactionViewModel {
    var id = ""
    var date = Date.now
    var merchant = ""
    var amount = 0.0
    var category = ""
    var type = ""
    var isExpense = true
    var isTransfer = false
    var accountName = ""
}
