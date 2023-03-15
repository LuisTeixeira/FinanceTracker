//
//  RecentTransactionView.swift
//  FinanceTracker
//
//  Created by Luís Teixeira on 16.03.23.
//

import SwiftUI

struct RecentTransactionView: View {
    var transactionViewModel : TransactionViewModel
    
    var body: some View {
        HStack(spacing: 20) {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.gray.opacity(0.3))
                .frame(width: 44, height: 44)
                
            VStack(alignment: .leading, spacing: 6) {
                Text(transactionViewModel.merchant)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                
                Text(transactionViewModel.accountName)
                    .font(.footnote)
                    .bold()
                    .lineLimit(1)
                
                Text(transactionViewModel.category)
                    .font(.footnote)
                    .opacity(0.7)
                    .lineLimit(1)
                
                Text(transactionViewModel.date, format: .dateTime.day().month().year())
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text(transactionViewModel.amount, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                .bold()
                .foregroundColor(transactionViewModel.isExpense ? Color.expense : Color.income)
        }.padding([.top, .bottom], 8)
    }
}

