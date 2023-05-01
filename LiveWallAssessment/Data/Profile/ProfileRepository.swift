//
//  ProfileRepository.swift
//  LiveWallAssessment
//
//  Created by Josian van Efferen on 01/05/2023.
//

import Foundation

class ProfileRepository {
    private let remote: ProfileRemoteDatasource = ProfileRemoteDatasource()
    func getProfile(token: String) async -> ProfileDTO? {
        let profile:ProfileDTO? = await remote.getProfile(token: token)
        return profile
    }
    
}
