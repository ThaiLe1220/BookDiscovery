//
//  NavigationBar.swift
//  BookDiscovery
//
//  Created by Thai, Le Hong on 14/09/2023.
//

import SwiftUI

struct NavigationBar: View {
    @ObservedObject var userViewModel : UserViewModel
    var performSearch: () -> Void
    
    var body: some View {
        HStack (spacing: 0) {
            // Search Bar
            TextField("", text: $userViewModel.searchText, onCommit: performSearch)
                .padding(8)
                .padding(.horizontal, 25)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(20)
                .padding(.horizontal, 20)
                .foregroundColor(.gray)
                .autocapitalization(.none)
//                .disableAutocorrection(true)
                .overlay(
                    HStack {
                        if userViewModel.searchText.isEmpty {
                            Image(systemName: "magnifyingglass")
                            Text("Search")
                        }
                    }
                        .foregroundColor(.gray)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 30)
                )

            Spacer()
                .frame(width: 0)

            Button(action: {
                userViewModel.showSettings = true
            }) {
                Image(systemName: "gearshape")
                    .font(.system(size: 24))
            }
        }
        .padding(.horizontal, 8)
        .padding(.top, 0)
        
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar(userViewModel: UserViewModel(), performSearch: {})
    }
}
