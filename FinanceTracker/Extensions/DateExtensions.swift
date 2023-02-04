//
//  DateExtensions.swift
//  FinanceTracker
//
//  Created by Luís Teixeira on 30.01.23.
//

import Foundation

extension Date {
    var beginOfCurrentMonth: Date {
        var components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        components.day = 1
        return Calendar.current.date(from: components) ?? self
    }
    
    var beginOfNextMonth: Date {
        Calendar.autoupdatingCurrent.date(byAdding: .month, value: 1, to: self.beginOfCurrentMonth) ?? self
    }
}
