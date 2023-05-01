//
//  HomeView.swift
//  LiveWallAssessment
//
//  Created by Josian van Efferen on 29/04/2023.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject private var vm: HomeViewModel
    
    init(_authManager: AuthManager, _songSerice: SongService) {
        vm = HomeViewModel(_authManager: _authManager, _songService: _songSerice)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                ForEach(vm.songs) { song in
                    SongView(song: song)
                }
            }
            
            
        }.onAppear() {
            vm.getLikedSongs()
        }
        
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
