//
//  LiveWallAssessmentApp.swift
//  LiveWallAssessment
//
//  Created by Josian van Efferen on 29/04/2023.
//

import SwiftUI

@main
struct LiveWallAssessmentApp: App {
    private let authManager: AuthManager
    private let profileRepo: ProfileRepository
    private let profileService: ProfileService
    
    init() {
        authManager = AuthManager()
        profileRepo = ProfileRepository()
        profileService = ProfileService(profileRepo: profileRepo)
    }
    
    @State private var showLoginPage: Bool = true
    
    var body: some Scene {
        WindowGroup {
            if (showLoginPage) {
                LoginView(_showLoginPage: $showLoginPage, _authManager: authManager)
            } else {
                TabView {
                    HomeView()
                        .tabItem {
                            Label("Home", systemImage: "house.fill")
                        }
                    
                    ProfileView(_profileService: profileService, _authManager: authManager)
                        .tabItem {
                            Label("Profile", systemImage: "person.circle.fill")
                        }
                }
            }
            
            
        }
    }
}
