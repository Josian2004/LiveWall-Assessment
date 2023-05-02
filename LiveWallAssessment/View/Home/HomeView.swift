//
//  HomeView.swift
//  LiveWallAssessment
//
//  Created by Josian van Efferen on 29/04/2023.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject private var vm: HomeViewModel
    @State private var loadingSongs: Bool = false
    
    init(_authManager: AuthManager, _songSerice: SongService) {
        vm = HomeViewModel(_authManager: _authManager, _songService: _songSerice)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                LazyVStack {
                    ForEach((0..<vm.songs.count), id: \.self) { i in
                        let song: Song = vm.songs[i]
                        HStack {
                            NavigationLink(destination: DetailView(song: song, _vm: vm), label: {
                                SongView(song: song, _vm: vm)
                                    .frame(
                                        minWidth: 0,
                                        maxWidth: .infinity,
                                        alignment: .leading
                                    )
                            })
                        }.onAppear {
                            if (i > vm.songs.count - 10 && !loadingSongs) {
                                loadingSongs = true
                                vm.loadNextPageSavedSongs() { loading in
                                    loadingSongs = loading
                                }
                            }
                        }
                        Divider().background(Color.accentColor)
                    }
                    
                }
                .navigationTitle("Liked Songs")
                .toolbar {
                    if (vm.lastDeletedSong != nil) {
                        Button("Undo", action: {vm.undoLastDelete()})
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20.0)
                .frame(minWidth: 0, maxWidth: .infinity)
                
            }.refreshable {
                vm.getSavedSongs()
            }
            
            
        }.onAppear() {
            vm.getSavedSongs()
        }
        
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
