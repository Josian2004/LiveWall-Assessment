//
//  SongDTO.swift
//  LiveWallAssessment
//
//  Created by Josian van Efferen on 01/05/2023.
//

import Foundation

struct SongDTO: Codable {
    let coverImageUrl: String
    let name: String
    let id: String
    let releaseDate: Int
    let artists: [ArtistDTO]
    let duration: Int
}
