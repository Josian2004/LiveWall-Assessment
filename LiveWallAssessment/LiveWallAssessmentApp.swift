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
    
    private let songRepo: SongRepository
    private let songService: SongService
    
    init() {
        authManager = AuthManager()
        
        profileRepo = ProfileRepository()
        profileService = ProfileService(profileRepo: profileRepo)
        
        songRepo = SongRepository()
        songService = SongService(songRepo: songRepo)
    }
    
    @State private var showLoginPage: Bool = true
    
    var body: some Scene {
        WindowGroup {
            if (showLoginPage) {
                LoginView(_showLoginPage: $showLoginPage, _authManager: authManager)
            } else {
                TabView {
                    HomeView(_authManager: authManager, _songSerice: songService)
                        .tabItem {
                            Label("Liked", systemImage: "music.note")
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
