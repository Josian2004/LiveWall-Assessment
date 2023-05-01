//
//  ProfileDTO.swift
//  LiveWallAssessment
//
//  Created by Josian van Efferen on 01/05/2023.
//

import Foundation

struct ProfileDTO: Codable {
    let country: String
    let display_name: String
    let followers: Profile_FollowersDTO
    let id: String
    let images: [Profile_ImageDTO]
    let product: String
}


struct Profile_FollowersDTO: Codable {
    let href: String?
    let total: Int
}

struct Profile_ImageDTO: Codable {
    let url: String
    let height: Int
    let width: Int
}
