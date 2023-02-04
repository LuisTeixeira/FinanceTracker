//
//  AuthenticationHeader.swift
//  FinanceTracker
//
//  Created by Luís Teixeira on 02.02.23.
//

import SwiftUI

struct AuthenticationHeader: View {
    let title: String
    let subtitle: String
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
            }
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            Text(subtitle)
                .font(.largeTitle)
                .fontWeight(.semibold)
        }
        .frame(height: 260)
        .padding(.leading)
        .background(Color(.systemFill))
    }
}

struct AuthenticationHeader_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationHeader(title: "Hello.", subtitle: "Create an account")
    }
}
