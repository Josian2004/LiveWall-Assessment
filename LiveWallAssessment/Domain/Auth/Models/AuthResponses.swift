//
//  Token.swift
//  LiveWallAssessment
//
//  Created by Josian van Efferen on 01/05/2023.
//

import Foundation

struct AuthResponse: Codable {
    let access_token: String
    let expires_in: Int
    let refresh_token: String
    let scope: String?
    let token_type:String
}


struct RefreshResponse: Codable {
    let access_token: String
    let expires_in: Int
    let scope: String?
    let token_type:String
}
