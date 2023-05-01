//
//  SongView.swift
//  LiveWallAssessment
//
//  Created by Josian van Efferen on 01/05/2023.
//

import SwiftUI

struct SongView: View {
    private let song: Song
    
    init(song: Song) {
        self.song = song
    }
    
    var body: some View {
        VStack {
            Text(song.name)
            Text(song.id)
            Text(song.artists[0].name)
        }
        .background(.red)
        .padding()
    }
}

//struct SongView_Previews: PreviewProvider {
//    static var previews: some View {
//        SongView(song: Song(coverImageUrl: "Test", name: "TestSong", id: "123", releaseDate: 0, artists: [], duration: 0))
//    }
//}
