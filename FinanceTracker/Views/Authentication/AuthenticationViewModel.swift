//
//  AuthenticationViewModel.swift
//  FinanceTracker
//
//  Created by Luís Teixeira on 04.02.23.
//

import Foundation
import FirebaseAuth

class AuthenticationViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var didAuthenticateUser = false
    
    private let authService = AuthenticationService()
    
    init() {
        self.userSession = authService.currentUser()
    }
    
    func register(withEmail email: String, passwored: String, fullname: String) {
        authService.register(withEmail: email, password: passwored, fullname: fullname) { user in
            self.userSession = user
            self.didAuthenticateUser = true
        }
    }
    
    func login(withEmail email: String, password: String) {
        authService.login(withEmail: email, password: password) { user in
            self.userSession = user
        }
    }
}
