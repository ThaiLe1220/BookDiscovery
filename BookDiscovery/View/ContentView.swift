//
//  ContentView.swift
//  BookDiscovery
//
//  Created by Lê Ngọc Trâm on 11/09/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var userViewModel = UserViewModel()

    var body: some View {
        NavigationView {
            if userViewModel.isSignedIn {
                UserProfileView(userViewModel: userViewModel)
            } else {
                UserSignInView(userViewModel: userViewModel)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
