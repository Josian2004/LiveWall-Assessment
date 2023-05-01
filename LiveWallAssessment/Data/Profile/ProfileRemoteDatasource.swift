//
//  ProfileRemoteDatasource.swift
//  LiveWallAssessment
//
//  Created by Josian van Efferen on 01/05/2023.
//

import Foundation

class ProfileRemoteDatasource {
    
    func getProfile(token: String) async -> ProfileDTO? {
        return await withCheckedContinuation { continuation in
            guard let requestUrl = URL(string:"https://api.spotify.com/v1/me") else {
                continuation.resume(returning: nil)
                return
            }
            
            var request = URLRequest(url: requestUrl)
            request.httpMethod = "GET"
            
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            let task = URLSession.shared.dataTask(with: request) {data, _, error in
                guard let data1 = data, error == nil else {
                    print("Error: \(error!.localizedDescription)")
                    continuation.resume(returning: nil)
                    return
                }
                do {
                    let result = try JSONDecoder().decode(ProfileDTO.self, from: data1)
                    continuation.resume(returning: result)
                }
                catch {
                    print("Error: \(error.localizedDescription)")
                    continuation.resume(returning: nil)
                }
            }
            task.resume()
        }
    }
}
