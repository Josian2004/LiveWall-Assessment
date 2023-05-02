//
//  DetailView.swift
//  LiveWallAssessment
//
//  Created by Josian van Efferen on 29/04/2023.
//

import SwiftUI

struct DetailView: View {
    private let song: Song
    @ObservedObject private var vm: HomeViewModel
    init(song: Song, _vm: HomeViewModel) {
        self.song = song
        self.vm = _vm
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                AsyncImage(url: URL(string: song.coverImageUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(1/1, contentMode: .fit)
                        .frame(
                          minWidth: 0,
                          maxWidth: .infinity,
                          alignment: .leading)
                        .padding(.horizontal, 10)
                } placeholder: {
                    Rectangle()
                        .aspectRatio(1/1, contentMode: .fit)
                        .frame(
                          minWidth: 0,
                          maxWidth: .infinity,
                          alignment: .leading)
                        .padding(.horizontal, 10)
                        .background(Color(UIColor.secondarySystemBackground))
                }
                VStack(alignment: .leading) {
                    Text(song.artists[0].name)
                        .font(.title)
                        .fontWeight(.semibold)
                    Text("Artist")
                        .font(.body)
                        .foregroundColor(Color(UIColor.secondaryLabel))
                        .fontWeight(.semibold)
                } .padding(.horizontal, 20)
                
                
                Text("Duration: \(Int(floor(Double(song.duration)/60)))min \(Int(Double(song.duration) - floor(Double(song.duration)/60)*60))sec")
                Spacer()
                Button("Delete from saved", role: .destructive, action: {vm.deleteFromSaved(song: self.song)})
                    .padding(.bottom, 20)
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.capsule)
                
                
            }.navigationTitle(song.name)
                .toolbar {
                    if (vm.lastDeletedSong != nil) {
                        Button("Undo", action: {vm.undoLastDelete()})
                    }
                }
        }
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
