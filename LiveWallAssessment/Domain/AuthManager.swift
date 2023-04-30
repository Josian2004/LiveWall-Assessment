//
//  AuthManager.swift
//  LiveWallAssessment
//
//  Created by Josian van Efferen on 30/04/2023.
//

import Foundation

class AuthManager {
    
    public let baseUrl: String = "https://accounts.spotify.com"
    public let clientId: String = "e47c2e3919cc4e6eace88ea4012182d1"
    public let clientSecret: String = "e9c6c5c6fc1a43c3a292bf3e92665b09"
    public let redirectUri: String = "https://josian.nl"
    
    func getAuthorizationUrl() -> String {
        return "\(baseUrl)/authorize?client_id=\(clientId)&response_type=code&redirect_uri=https://josian.nl"
    }
    
    func getCodeFromUrl(url: String) -> Bool {
        let component = URLComponents(string: url)
        guard let code = component?.queryItems?.first(where: { $0.name == "code"})?.value else {
            return false
        }
        print(code)
        return true
    }
}
