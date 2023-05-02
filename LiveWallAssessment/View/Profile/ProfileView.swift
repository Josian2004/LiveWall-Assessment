//
//  ProfileView.swift
//  LiveWallAssessment
//
//  Created by Josian van Efferen on 29/04/2023.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject private var vm: ProfileViewModel
    
    init(_profileService: ProfileService, _authManager: AuthManager) {
        vm = ProfileViewModel(_profileService: _profileService, _authManager: _authManager)
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    AsyncImage(url: URL(string: vm.profileImageUrl)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .aspectRatio(1/1, contentMode: .fit)
                            .frame( height: 150, alignment: .leading)
                            .clipped()
                            .cornerRadius(200)
                            
                    } placeholder: {
                        Rectangle()
                            .aspectRatio(1/1, contentMode: .fit)
                            .cornerRadius(200)
                            .frame( height: 150, alignment: .leading)
                            .background(Color(UIColor.secondarySystemBackground))
                    }.padding(20)
                    
                    VStack(alignment: .leading) {
                        Text(vm.displayName)
                            .font(.title)
                            .fontWeight(.semibold)
                        HStack(alignment: .lastTextBaseline, spacing: 0) {
                            Text(String(vm.followerCount))
                                .font(.title3)
                                .fontWeight(.semibold)
                            Spacer().frame(width: 3)
                            Text("followers")
                                .font(.subheadline)
                                .fontWeight(.regular)
                                .foregroundColor(Color(UIColor.secondaryLabel))
                        }
                    }
                    
                    Spacer()
                }
                Divider().background(Color.accentColor)
                Spacer()
            }
            .navigationTitle("Profile")
            .padding(.horizontal, 20)
            .padding(.top, 20.0)
            .frame(minWidth: 0, maxWidth: .infinity)
            .onAppear() {
                vm.getProfile()
            }
        }
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView(_profileRepo: ProfileRepository())
//    }
//}
