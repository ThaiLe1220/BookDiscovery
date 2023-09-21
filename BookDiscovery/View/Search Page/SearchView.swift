//
//  SearchView.swift
//  BookDiscovery
//
//  Created by Thai, Le Hong on 14/09/2023.
//

import SwiftUI

struct SearchView: View {
    @Binding var isOn: Bool
    @ObservedObject var userViewModel : UserViewModel
    @ObservedObject var bookViewModel: BookViewModel
    @ObservedObject var reviewViewModel: ReviewViewModel
    
    @State var searchResults: [Book] = []
    
    var body: some View {
        NavigationView {
            VStack (spacing: 0) {
                NavigationBar(userViewModel: userViewModel)
                
                NavigationLink(destination: SettingView(isOn: $isOn, userViewModel: userViewModel), isActive: $userViewModel.showSettings) {
                    Text("").hidden()
                }
                .opacity(0)
                .frame(width: 0, height: 0)
                
                Divider()

            
                Spacer()
                Divider()
            }
            .background(Color(UIColor.secondarySystemBackground))
            .onAppear {
                userViewModel.searchText = ""
                userViewModel.showSearch = false
                searchResults = bookViewModel.books
            }
            .onChange(of: userViewModel.searchText) { text in
                text == "" ? searchResults = bookViewModel.books : performSearch()
            }
        }
    }
    
    // Function to perform the search
    func performSearch() {
        
        searchResults = bookViewModel.books.filter { book in
            book.name.lowercased().contains(userViewModel.searchText.lowercased())
        }
        
        userViewModel.currentUser.searchHistory.append(userViewModel.searchText)
        FireBaseDB().updateUser(user: userViewModel.currentUser) { success, error in
            if success {
                print("search query added to search history")
            } else {
                print(error?.localizedDescription ?? "Unknown Error")
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(isOn: .constant(false), userViewModel: UserViewModel(), bookViewModel: BookViewModel(), reviewViewModel: ReviewViewModel())
    }
}
