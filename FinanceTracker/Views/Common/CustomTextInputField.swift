//
//  CustomTextInputField.swift
//  FinanceTracker
//
//  Created by Luís Teixeira on 02.02.23.
//

import SwiftUI

struct CustomTextInputField: View {
    let imageName: String
    let placeholderText: String
    var isSecureField: Bool? = false
    @Binding var text: String
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color(.darkGray))
                
                if isSecureField ?? false {
                    SecureField(placeholderText, text: $text)
                } else {
                    TextField(placeholderText, text: $text)
                }
            }
            Divider()
        }
    }
}

struct CustomTextInputField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextInputField(imageName: "envelope", placeholderText: "Email", text: .constant(""))
    }
}
