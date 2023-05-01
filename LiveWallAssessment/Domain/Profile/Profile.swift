//
//  Profile.swift
//  LiveWallAssessment
//
//  Created by Josian van Efferen on 01/05/2023.
//

import Foundation

class Profile {
    let country: String
    let display_name: String
    let followers: Int
    let id: String
    let images: [Profile_Image]
    let product: String
    
    init(country: String, display_name: String, followers: Int, id: String, images: [Profile_Image], product: String) {
        self.country = country
        self.display_name = display_name
        self.followers = followers
        self.id = id
        self.images = images
        self.product = product
    }
}

class Profile_Image {
    let url: String
    let height: Int
    let width: Int
    
    init(url: String, height: Int, width: Int) {
        self.url = url
        self.height = height
        self.width = width
    }
}
