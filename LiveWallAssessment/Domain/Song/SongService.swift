//
//  SongService.swift
//  LiveWallAssessment
//
//  Created by Josian van Efferen on 01/05/2023.
//

import Foundation

class SongService {
    private let songRepo: SongRepository
    
    init(songRepo: SongRepository) {
        self.songRepo = songRepo
    }
    
    func getSavedSongs(token: String, page: Int) async -> [Song] {
        var songs: [Song] = []
        let songDTOs: [SongDTO] = await songRepo.getSavedSongs(token: token, page: page)
        songDTOs.forEach({songDTO in
            
            var artists: [Artist] = []
            songDTO.artists.forEach({artistDTO in
                artists.append(Artist(name: artistDTO.name, id: artistDTO.id))
            })
            
            songs.append(Song(
                coverImageUrl: songDTO.coverImageUrl,
                name: songDTO.name,
                id: songDTO.id,
                releaseDate: songDTO.releaseDate,
                artists: artists,
                duration: songDTO.duration))
        })
        
        return songs
    }
}
