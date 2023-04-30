//
//  HomeView.swift
//  LiveWallAssessment
//
//  Created by Josian van Efferen on 29/04/2023.
//

import SwiftUI

struct HomeView: View {
    private let vm: HomeViewModel = HomeViewModel()
    var body: some View {
        NavigationStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
