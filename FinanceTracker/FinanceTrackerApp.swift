//
//  FinanceTrackerApp.swift
//  FinanceTracker
//
//  Created by Luís Teixeira on 28.01.23.
//

import SwiftUI
import Firebase

@main
struct FinanceTrackerApp: App {
    
    @State var authenticationViewModel: AuthenticationViewModel
    
    init() {
        FirebaseApp.configure()
        authenticationViewModel = AuthenticationViewModel()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
            .environmentObject(authenticationViewModel)
        }
    }
}
