//
//  HomeViewModel.swift
//  LiveWallAssessment
//
//  Created by Josian van Efferen on 29/04/2023.
//

import Foundation

class HomeViewModel: ObservableObject {
    private let songService: SongService
    private let authManager: AuthManager
    
    init(_authManager: AuthManager ,_songService: SongService) {
        self.songService = _songService
        self.authManager = _authManager
    }
    
    @Published var songs: [Song] = []
    
    func getLikedSongs() {
        Task.init {
            let songs: [Song] = await songService.getSavedSongs(token: authManager.token!, page: 0)
            
            DispatchQueue.main.async {
                self.songs = songs
            }
        }
    }
    
}
