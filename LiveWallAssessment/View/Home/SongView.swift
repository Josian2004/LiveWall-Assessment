//
//  SongView.swift
//  LiveWallAssessment
//
//  Created by Josian van Efferen on 01/05/2023.
//

import SwiftUI

struct SongView: View {
    private let song: Song
    @ObservedObject private var vm: HomeViewModel
    init(song: Song, _vm: HomeViewModel) {
        self.song = song
        self.vm = _vm
    }
    
    var body: some View {
        HStack {
            HStack {
                AsyncImage(url: URL(string: song.coverImageUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 35, height: 35)
                } placeholder: {
                    Rectangle()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 35, height: 35)
                        .background(Color(UIColor.secondarySystemBackground))
                }
                
                VStack(alignment: .leading) {
                    Text(song.name)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(UIColor.label))
                        .lineLimit(1)
                        .truncationMode(.tail)
                    Text(song.artists[0].name)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(UIColor.secondaryLabel))
                        .lineLimit(1)
                        .truncationMode(.tail)
            }
            }
            Spacer()
            Button(action: {vm.deleteFromSaved(song: song)}, label: {
                Image(systemName: "trash").font(.title2)
            })
        }
        .padding(.trailing, 20)
    }
}

//struct SongView_Previews: PreviewProvider {
//    static var previews: some View {
//        SongView(song: Song(coverImageUrl: "Test", name: "TestSong", id: "123", releaseDate: 0, artists: [], duration: 0))
//    }
//}
