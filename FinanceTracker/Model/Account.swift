//
//  Account.swift
//  FinanceTracker
//
//  Created by Luís Teixeira on 25.02.23.
//

import Foundation
import FirebaseFirestoreSwift

struct Account: Identifiable, Decodable, Encodable, Hashable {
    @DocumentID var id = ""
    var accountName = ""
    var accountValue: Double = .zero
}
