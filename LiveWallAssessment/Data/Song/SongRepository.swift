//
//  SongRepository.swift
//  LiveWallAssessment
//
//  Created by Josian van Efferen on 01/05/2023.
//

import Foundation

class SongRepository {
    private let remote: SongRemoteDatasource = SongRemoteDatasource()
    
    typealias JSONStandard = [String: AnyObject]
    
    func getSavedSongs(token: String, page: Int) async -> [SongDTO] {
        guard let data: Data = await remote.getSavedSongs(token: token, page: page) else { return [] }
        do {
            var songs: [SongDTO] = []
            let likedSongsResponse: LikedSongsResponse = try JSONDecoder().decode(LikedSongsResponse.self, from: data)
            likedSongsResponse.items?.forEach({item in
                
                var artists: [ArtistDTO] = []
                item.track.artists?.forEach({ artist in
                    artists.append(ArtistDTO(name: artist.name, id: artist.id))
                })
                
                let song: SongDTO = SongDTO(
                    coverImageUrl: item.track.album?.images?[0].url ?? "placeholder",
                    name: item.track.name,
                    id: item.track.id,
                    releaseDate: 0,
                    artists: artists,
                    duration: (item.track.durationMS ?? 0)/1000)
                songs.append(song)
            })
            return songs
            
        }
        catch {
            print("Error info: \(error)")
            return []
        }
        
    }
    
    func removeFromSavedSongs(token: String, songId: String) {
        remote.removeFromSavedSongs(token: token, songId: songId)
    }
    
    func addToSavedSongs(token: String, songId: String) async {
        remote.addToSavedSongs(token: token, songId: songId)
    }
}
