//
//  AccountRowView.swift
//  FinanceTracker
//
//  Created by Luís Teixeira on 26.02.23.
//

import Foundation
import SwiftUI

struct AccountRowView : View {
    var account : Account
    
    var body: some View {
        HStack(spacing: 20) {
            Text(account.accountName)
                .font(.subheadline)
                .bold()
                .lineLimit(1)
            
            Spacer()
            
            Text(account.accountValue, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                .bold()
                .foregroundColor(account.accountValue < 0 ? Color.expense : Color.income)
        }.padding([.top, .bottom], 8)
    }
}

struct AccountRowView_Preview: PreviewProvider {
    static var previews: some View {
        AccountRowView(account: Account(id: "", accountName: "BBBank", accountValue: 26000))
    }
}
