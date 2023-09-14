//
//  WishlistView.swift
//  BookDiscovery
//
//  Created by Thai, Le Hong on 14/09/2023.
//

import SwiftUI

struct WishlistView: View {
    @ObservedObject var userViewModel = UserViewModel()


    
    var body: some View {
        NavigationStack {
            VStack {
                NavigationBar(userViewModel: userViewModel)
                Text("Wishlist View")
                
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

struct WishlistView_Previews: PreviewProvider {
    static var previews: some View {
        WishlistView(userViewModel: UserViewModel())
    }
}