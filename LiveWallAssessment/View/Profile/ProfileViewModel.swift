//
//  ProfileViewModel.swift
//  LiveWallAssessment
//
//  Created by Josian van Efferen on 29/04/2023.
//

import Foundation

class ProfileViewModel: ObservableObject {
    private let profileService: ProfileService
    private let authManager: AuthManager
    
    init(_profileService: ProfileService, _authManager: AuthManager) {
        profileService = _profileService
        authManager = _authManager
    }
    
    @Published var country: String = "No Country"
    @Published var displayName: String = "Spotify User"
    @Published var followerCount: Int = 0
    @Published var product: String = "No Subscription"
    @Published var profileImageUrl: String = "https://dummyimage.com/600x600/757575/fff.jpg&text=Profile+Picture"
    
    func getProfile() {
        Task.init {
            let profile: Profile? = await profileService.getProfile(token: authManager.token!)
            if (profile != nil) {
                DispatchQueue.main.async {
                    self.country = profile!.country
                    self.displayName = profile!.display_name
                    self.followerCount = profile!.followers
                    self.product = profile!.product
                    self.profileImageUrl = profile!.images[0].url
                }
            }
            
        }
        
    }
}
