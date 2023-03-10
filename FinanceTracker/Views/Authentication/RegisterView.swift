//
//  RegisterView.swift
//  FinanceTracker
//
//  Created by Luís Teixeira on 02.02.23.
//

import SwiftUI

struct RegisterView: View {
    @State private var email = ""
    @State private var fullname = ""
    @State private var password = ""
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    
    var body: some View {
        VStack {
            AuthenticationHeader(title: "Welcome", subtitle: "Create Your account")
            
            VStack(spacing: 40) {
                CustomTextInputField(imageName: "envelope", placeholderText: "Email", text: $email)
                CustomTextInputField(imageName: "person", placeholderText: "Full name", text: $fullname)
                CustomTextInputField(imageName: "lock", placeholderText: "Password", isSecureField: true, text: $password)
            }
            .padding(32)
            
            Button {
                authenticationViewModel.register(withEmail: email, passwored: password, fullname: fullname)
            } label: {
                Text("Sign up")
                    .font(.headline)
                    .foregroundColor(.primary)
                    .frame(width: 340, height: 50)
                    .background(Color(.systemFill))
                    .clipShape(Capsule())
                    .padding()
            }
            .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
            
            Spacer()
            
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                HStack {
                    Text("Already have an account")
                        .font(.footnote)
                    Text("Sign In")
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                .padding(.bottom, 32)
                .foregroundColor(.primary)
            }
            .padding(32)
        }
        .ignoresSafeArea()
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
