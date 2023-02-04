//
//  Transaction.swift
//  FinanceTracker
//
//  Created by Luís Teixeira on 28.01.23.
//

import Foundation
import FirebaseFirestoreSwift

struct Transaction : Identifiable, Decodable, Encodable, Hashable {
    @DocumentID var id = ""
    var date = Date.now
    var account = ""
    var merchant = ""
    var amount = 0.0
    var category = ""
    var type = ""
    var isExpense = true
    var isTransfer = false
    
    var signedAmount: Double {
        return isExpense ? -amount : amount
    }
}
