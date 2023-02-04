//
//  LoginView.swift
//  FinanceTracker
//
//  Created by Luís Teixeira on 02.02.23.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    
    var body: some View {
        VStack {
            AuthenticationHeader(title: "Hello", subtitle: "Welcome Back")
            
            VStack(spacing: 40) {
                CustomTextInputField(imageName: "envelope", placeholderText: "Email", text: $email)
                CustomTextInputField(imageName: "lock", placeholderText: "Passwrod", isSecureField: true,
                    text: $password)
            }
            .padding(32)
                        
            Button {
                authenticationViewModel.login(withEmail: email, password: password)
            } label: {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.primary)
                    .frame(width: 340, height: 50)
                    .background(Color(.systemFill))
                    .clipShape(Capsule())
                    .padding()
            }
            .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
            
            Spacer()
            
            NavigationLink {
                RegisterView()
                    .navigationBarHidden(true)
            } label: {
                HStack {
                    Text("Don't have an account")
                        .font(.footnote)
                    Text("Sign Up")
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                .padding(.bottom, 32)
                .foregroundColor(.primary)
            }
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
