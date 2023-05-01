//
//  LoginViewModel.swift
//  LiveWallAssessment
//
//  Created by Josian van Efferen on 29/04/2023.
//

import Foundation



class LoginViewModel: ObservableObject {
    
    let authManager: AuthManager
    
    init(authManager: AuthManager) {
        self.authManager = authManager
    }
    
    func loginAttempt(url: String, completion: @escaping (Bool) -> Void) {
        authManager.getCodeFromUrl(url: url, completion: {code, exists in
            if (exists) {
                self.authManager.exchangeCodeForToken(code: code, completion: {success in
                    completion(success)
                })
            } else {
                completion(false)
            }
        })
    }
}
