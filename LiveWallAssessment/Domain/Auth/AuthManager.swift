//
//  AuthManager.swift
//  LiveWallAssessment
//
//  Created by Josian van Efferen on 30/04/2023.
//

import Foundation

class AuthManager {
    
    public let baseUrl: String = "https://accounts.spotify.com"
    public let clientId: String = Bundle.main.infoDictionary?["Spotify_ClientId"] as! String
    public let clientSecret: String = Bundle.main.infoDictionary?["Spotify_ClientSecret"] as! String
    public let redirectUri: String = "https://josian.nl"
    public let scopes: String = "user-read-playback-state+user-modify-playback-state+user-read-currently-playing+playlist-read-private+playlist-read-collaborative+playlist-modify-private+playlist-modify-public+user-follow-read+user-top-read+user-read-recently-played+user-library-modify+user-library-read+user-read-email+user-read-private"
    
    func getAuthorizationUrl() -> URL {
        let url: URL = URL(string:"\(baseUrl)/authorize?client_id=\(clientId)&scope=\(scopes)&response_type=code&redirect_uri=\(redirectUri)&show_dialog=false")!
        return url
    }
    
    func getCodeFromUrl(url: String, completion: @escaping (String, Bool) -> Void) {
        let component = URLComponents(string: url)
        guard let code = component?.queryItems?.first(where: { $0.name == "code"})?.value else {
            print("No code present")
            completion("", false)
            return
        }
        completion(code, true)
    }
    
    func exchangeCodeForToken(code: String, completion: @escaping (Bool) -> Void) {
        guard let requestUrl = URL(string:"\(baseUrl)/api/token") else { return }
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: redirectUri)
        ]

        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let basicToken = clientId+":"+clientSecret
        guard let base64String = basicToken.data(using: .utf8)?.base64EncodedString() else {
            print("Failed to encode to base64")
            completion(false)
            return
        }
        
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        request.httpBody = components.query?.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) {data, _, error in
            guard let data = data, error == nil else {
                print("Error: \(error!.localizedDescription)")
                completion(false)
                return
            }
            do {
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                self.saveToken(authResponse: result)
                print("Login Succeeded")
                completion(true)
            }
            catch {
                print("Error: \(error.localizedDescription)")
                completion(false)
            }
        }
        task.resume()
    }
    
    private func saveToken(authResponse: AuthResponse) {
        UserDefaults.standard.set(authResponse.access_token, forKey: "access_token")
        UserDefaults.standard.set(authResponse.refresh_token, forKey: "refresh_token")
        UserDefaults.standard.set(Int(Date().timeIntervalSince1970) + authResponse.expires_in, forKey: "expiration_date")
    }
    
    private func saveRefreshedToken(refreshResponse: RefreshResponse) {
        UserDefaults.standard.set(refreshResponse.access_token, forKey: "access_token")
        UserDefaults.standard.set(Int(Date().timeIntervalSince1970) + refreshResponse.expires_in, forKey: "expiration_date")
    }
    
    private func requestRefreshedToken(completion: @escaping (Bool) -> Void) {
        guard let requestUrl = URL(string:"\(baseUrl)/api/token") else { return }
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "refresh_code"),
            URLQueryItem(name: "refresh_token", value: refreshToken),
        ]

        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let basicToken = clientId+":"+clientSecret
        guard let base64String = basicToken.data(using: .utf8)?.base64EncodedString() else {
            print("Failed to encode to base64")
            completion(false)
            return
        }
        
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        request.httpBody = components.query?.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) {data, _, error in
            guard let data = data, error == nil else {
                print("Error: \(error!.localizedDescription)")
                completion(false)
                return
            }
            do {
                let result = try JSONDecoder().decode(RefreshResponse.self, from: data)
                self.saveRefreshedToken(refreshResponse: result)
                print("Refresh Succeeded")
                completion(true)
            }
            catch {
                print("Error: \(error.localizedDescription)")
                completion(false)
            }
        }
        task.resume()
    }
    
    private var isExpired: Bool {
        return Int(Date().timeIntervalSince1970) > UserDefaults.standard.integer(forKey: "expiration_date")
    }
    
    var isLoggedIn: Bool {
        return token != nil
    }
    
    var token: String? {
        if (isExpired) {
            requestRefreshedToken(completion: {success in
                if (success) {
                    return
                } else {
                    // error handling of some kind
                    return
                }
            })
        }
        return UserDefaults.standard.string(forKey: "access_token")
    }
    
    private var refreshToken: String? {
        return UserDefaults.standard.string(forKey: "refresh_token")
    }
}
