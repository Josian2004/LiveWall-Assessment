//
//  DetailView.swift
//  LiveWallAssessment
//
//  Created by Josian van Efferen on 29/04/2023.
//

import SwiftUI

struct DetailView: View {
    private let song: Song
    private let durationMin: String
    private let durationSec: String
    @ObservedObject private var vm: HomeViewModel
    init(song: Song, _vm: HomeViewModel) {
        self.song = song
        self.vm = _vm
        let _durationMin = floor(Double(song.duration)/60)
        let _durationSec = Double(song.duration) - _durationMin*60
        self.durationMin = String(Int(_durationMin))
        self.durationSec = String(Int(_durationSec))
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
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
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text(song.artists[0].name)
                            .font(.title)
                            .fontWeight(.semibold)
                        Text("Artist")
                            .font(.body)
                            .foregroundColor(Color(UIColor.secondaryLabel))
                            .fontWeight(.semibold)
                    } .padding(.horizontal, 20)
                    Spacer()
                    VStack(alignment: .leading) {
                        HStack(alignment: .lastTextBaseline, spacing: 0) {
                            Text(durationMin)
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.accentColor)
                                .padding(0)
                            Text("min")
                                .font(.body)
                                .fontWeight(.semibold)
                                .padding(0)
                            Spacer().frame(width: 3)
                            Text(durationSec)
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.accentColor)
                                .padding(0)
                            Text("Sec")
                                .font(.body)
                                .fontWeight(.semibold)
                                .padding(0)
                        }
                        Text("Duration")
                            .font(.body)
                            .foregroundColor(Color(UIColor.secondaryLabel))
                            .fontWeight(.semibold)
                    }.padding(.horizontal, 20)
                    
                }
                
                
                
                
                Spacer()
                Button("Delete from Liked", role: .destructive, action: {vm.deleteFromSaved(song: self.song)})
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
