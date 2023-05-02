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
    @Published var lastDeletedSong: Song?
    
    func getSavedSongs() {
        Task.init {
            let songs: [Song] = await songService.getSavedSongs(token: authManager.token!, offset: 0)
            
            DispatchQueue.main.async {
                self.songs = songs
            }
        }
    }
    
    func loadNextPageSavedSongs(completion: @escaping (Bool) -> Void) {
        Task.init {
            let songs: [Song] = await songService.getSavedSongs(token: authManager.token!, offset: songs.count)
            
            DispatchQueue.main.async {
                self.songs = self.songs + songs
                completion(false)
            }
            
        }
    }
    
    func deleteFromSaved(song: Song) {
        Task.init {
            DispatchQueue.main.async {
                self.lastDeletedSong = song
            }
            await songService.deleteFromSavedSongs(token: authManager.token!, songId: song.id)
            self.getSavedSongs()
        }
    }
    
    func undoLastDelete() {
        guard let song = lastDeletedSong else { return }
        Task.init {
            await songService.addToSavedSongs(token: authManager.token!, songId: song.id)
            DispatchQueue.main.async {
                self.lastDeletedSong = nil
            }
        }
        self.getSavedSongs()
        
    }
    
}
