//
//  HomeView.swift
//  BookDiscovery
//
//  Created by Thai, Le Hong on 14/09/2023.
//

import SwiftUI

struct BrowseView: View {
    @Binding var isOn: Bool
    @ObservedObject var userViewModel: UserViewModel
    @ObservedObject var bookViewModel: BookViewModel
    @ObservedObject var reviewViewModel: ReviewViewModel
    
    @State var searchResults: [Book] = []

    var body: some View {
        NavigationStack {
            VStack (spacing: 0) {
                NavigationBar(userViewModel: userViewModel)
                NavigationLink(destination: SettingView(isOn: $isOn, userViewModel: userViewModel), isActive: $userViewModel.showSettings) {
                    Text("").hidden()
                }
                .opacity(0)
                .frame(width: 0, height: 0)
                
                Divider()
                if userViewModel.showSearch {
                    if searchResults.isEmpty {
                        Color(UIColor.secondarySystemBackground)
                    } else {
                        List(searchResults, id: \.id) { book in
                        NavigationLink(destination: BookDetailView(isOn: $isOn, userViewModel: userViewModel, bookViewModel: bookViewModel, currentBook: book), isActive: $userViewModel.showSettings){
                        Text(book.name)
                            }
                        }
                    }
                }
                else {
                    CategoryListView(isOn: $isOn, userViewModel: userViewModel, bookViewModel: bookViewModel, reviewViewModel: reviewViewModel)
                        .opacity(userViewModel.showSearch ? 0 : 1)
                }


                
                Spacer()
                
                Divider()
            }
            .background(Color(UIColor.secondarySystemBackground))

        }
        .onAppear {
            userViewModel.searchText = ""
            userViewModel.showSearch = false
            searchResults = bookViewModel.books
            userViewModel.isSearchBarVisible = false
        }
        .onChange(of: userViewModel.searchText) { text in
            text == "" ? searchResults = bookViewModel.books : performSearch()
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

struct BrowseView_Previews: PreviewProvider {
    static var previews: some View {
        BrowseView(isOn: .constant(false), userViewModel: UserViewModel(), bookViewModel: BookViewModel(), reviewViewModel: ReviewViewModel())
    }
}
