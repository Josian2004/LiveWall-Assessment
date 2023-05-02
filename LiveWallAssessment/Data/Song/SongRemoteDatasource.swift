//
//  SongRemoteDatasource.swift
//  LiveWallAssessment
//
//  Created by Josian van Efferen on 01/05/2023.
//

import Foundation

class SongRemoteDatasource {
    func getSavedSongs(token: String, offset: Int) async -> Data? {
        return await withCheckedContinuation { continuation in
            guard let requestUrl = URL(string:"https://api.spotify.com/v1/me/tracks?market=NL&limit=50&offset=\(offset)") else {
                continuation.resume(returning: nil)
                return
            }
            
            var request = URLRequest(url: requestUrl)
            
            request.httpMethod = "GET"
            
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            let task = URLSession.shared.dataTask(with: request) {data, _, error in
                guard let data = data, error == nil else {
                    print("Error: \(error!.localizedDescription)")
                    continuation.resume(returning: nil)
                    return
                }
                continuation.resume(returning: data)
            }
            task.resume()
        }
    }
    
    func removeFromSavedSongs(token: String, songId: String) async {
        guard let requestUrl = URL(string:"https://api.spotify.com/v1/me/tracks?ids=\(songId)") else {
            return
        }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "DELETE"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request){data, _, error in
            guard let _ = data, error == nil else {
                print("Error: \(error!.localizedDescription)")
                return
            }
        }
        task.resume()
    }
    
    func addToSavedSongs(token: String, songId: String) async {
        guard let requestUrl = URL(string:"https://api.spotify.com/v1/me/tracks?ids=\(songId)") else {
            return
        }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "PUT"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request){data, _, error in
            guard let _ = data, error == nil else {
                print("Error: \(error!.localizedDescription)")
                return
            }
        }
        task.resume()
    }
}
