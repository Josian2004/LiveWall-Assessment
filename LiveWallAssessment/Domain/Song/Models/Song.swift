//
//  Song.swift
//  LiveWallAssessment
//
//  Created by Josian van Efferen on 01/05/2023.
//

import Foundation

class Song: Identifiable{
    let coverImageUrl: String
    let name: String
    let id: String
    let releaseDate: Int
    let artists: [Artist]
    let duration: Int
    
    init(coverImageUrl: String, name: String, id: String, releaseDate: Int, artists: [Artist], duration: Int) {
        self.coverImageUrl = coverImageUrl
        self.name = name
        self.id = id
        self.releaseDate = releaseDate
        self.artists = artists
        self.duration = duration
    }
}
