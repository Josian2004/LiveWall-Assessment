//
//  LiveWallAssessmentApp.swift
//  LiveWallAssessment
//
//  Created by Josian van Efferen on 29/04/2023.
//

import SwiftUI

@main
struct LiveWallAssessmentApp: App {
    private let authManager: AuthManager = AuthManager()
    @State private var showLoginPage: Bool = true
    
    var body: some Scene {
        WindowGroup {
            if (showLoginPage) {
                LoginView(showLoginPage: $showLoginPage, authManager: authManager)
            } else {
                TabView {
                    HomeView()
                        .tabItem {
                            Label("Home", systemImage: "house.fill")
                        }
                    
                    ProfileView()
                        .tabItem {
                            Label("Profile", systemImage: "person.circle.fill")
                        }
                }
            }
            
            
        }
    }
}
