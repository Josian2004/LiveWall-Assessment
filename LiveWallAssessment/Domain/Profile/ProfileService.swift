//
//  ProfileService.swift
//  LiveWallAssessment
//
//  Created by Josian van Efferen on 01/05/2023.
//

import Foundation

class ProfileService {
    private let profileRepo: ProfileRepository
    
    init(profileRepo: ProfileRepository) {
        self.profileRepo = profileRepo
    }
    
    func getProfile(token: String) async -> Profile? {
        let profileDTO: ProfileDTO? = await profileRepo.getProfile(token: token)
        
        if (profileDTO != nil) {
            
            var images: [Profile_Image] = []
            profileDTO?.images.forEach({image in
                images.append(Profile_Image(url: image.url, height: image.height ?? 0, width: image.width ?? 0))
            })
            
            let profile:Profile = Profile(
                country: profileDTO?.country ?? "No Country",
                display_name: profileDTO?.display_name ?? "Spotify User",
                followers: profileDTO?.followers.total ?? 0,
                id: profileDTO?.id ?? "0",
                images: images,
                product: profileDTO?.product ?? "No Subscription")
            
            return profile
        } else {
            return nil
        }
    
        
    }
}
