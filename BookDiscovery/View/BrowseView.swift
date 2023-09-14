//
//  HomeView.swift
//  BookDiscovery
//
//  Created by Thai, Le Hong on 14/09/2023.
//

import SwiftUI

struct BrowseView: View {
    @ObservedObject var userViewModel = UserViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                NavigationBar(userViewModel: userViewModel)
                Text("Browse View")
                
                Spacer()
                NavigationLink(destination: SettingView(userViewModel: userViewModel), isActive: $userViewModel.showSettings) {
                    Text("").hidden()
                }
                .opacity(0)
                .frame(width: 0, height: 0)
            }
        }
    }
}

struct BrowseView_Previews: PreviewProvider {
    static var previews: some View {
        BrowseView(userViewModel: UserViewModel())
    }
}
