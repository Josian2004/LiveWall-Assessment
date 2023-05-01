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
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    Text(vm.displayName)
                    Text(vm.country)
                    Text(vm.product)
                    Text(String(vm.followerCount))
                    //AsyncImage(url: URL(string: vm.profileImageUrl)).frame(width: 20, height: 20)
                    Spacer().frame(minHeight: 20)
                }
                .navigationTitle("Profile")
                .padding(.horizontal, 20)
                .padding(.top, 20.0)
                .frame(minWidth: 0, maxWidth: .infinity)
            }
        }.onAppear() {
            vm.getProfile()
        }
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView(_profileRepo: ProfileRepository())
//    }
//}
