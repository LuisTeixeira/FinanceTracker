//
//  ContentView.swift
//  FinanceTracker
//
//  Created by Luís Teixeira on 28.01.23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    var body: some View {
        Group {
            if authenticationViewModel.userSession == nil {
                LoginView()
            } else {
                Overview()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
