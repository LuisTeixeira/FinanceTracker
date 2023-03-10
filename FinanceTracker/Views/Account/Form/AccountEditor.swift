//
//  AccountEditor.swift
//  FinanceTracker
//
//  Created by Luís Teixeira on 08.03.23.
//

import SwiftUI

struct AccountEditor: View {
    @Binding var account: Account
    
    let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter
    }()
    
    var body: some View {
        List{
            TextField("Account name", text: $account.accountName)
            TextField("Initial ammount", value: $account.accountValue, formatter: currencyFormatter)
        }
    }
    
}
