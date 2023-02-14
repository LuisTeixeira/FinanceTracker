//
//  TransactionEditor.swift
//  FinanceTracker
//
//  Created by Luís Teixeira on 01.02.23.
//

import SwiftUI

struct TransactionEditor: View {
    @Binding var transaction: Transaction
    
    let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        
        return formatter
    }()
    
    var body: some View {
        List {
            Section("What") {
                TextField("Amount", value: $transaction.amount, formatter: currencyFormatter)
                TextField("Merchant", text: $transaction.merchant)
                TextField("Account", text: $transaction.account)
            }
            
            Section("When") {
                DatePicker("Date", selection: $transaction.date, displayedComponents: .date)
            }
            
            Section("Info") {
                TextField("Category", text: $transaction.category)
                TextField("Type", text: $transaction.type)
                Toggle("Is Expense", isOn: $transaction.isExpense)
                Toggle("Is Transfer", isOn: $transaction.isTransfer)
            }
        }
        .background(Color.background)
    }
}

struct TransactionEditor_Previews: PreviewProvider {
    static var previews: some View {
        TransactionEditor(transaction: .constant(Transaction()))
    }
}
