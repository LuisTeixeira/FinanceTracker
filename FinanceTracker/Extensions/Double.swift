//
//  Double.swift
//  FinanceTracker
//
//  Created by Luís Teixeira on 19.02.23.
//

import Foundation

extension Double {
    
    var asCurrency: String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
    
}
