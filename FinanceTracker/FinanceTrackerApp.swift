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
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
