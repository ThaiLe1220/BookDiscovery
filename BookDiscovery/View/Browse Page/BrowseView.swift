//
//  HomeView.swift
//  BookDiscovery
//
//  Created by Thai, Le Hong on 14/09/2023.
//

import SwiftUI

struct BrowseView: View {
    @ObservedObject var userViewModel: UserViewModel
    @ObservedObject var bookViewModel: BookViewModel
    @ObservedObject var reviewViewModel: ReviewViewModel
    @State var scrollOffset: CGFloat = 0.0
    @State var showTitle: Bool = false
    
    @State var searchResults: [Book] = []

    var body: some View {
        NavigationView {
            ScrollView {
                VStack (spacing: 0) {
                    HeaderView(userViewModel: userViewModel, tabName: "Search")
                    
                    NavigationBar(userViewModel: userViewModel)
                        .padding(.top, 8)
                        .padding(.bottom, 16)
                    
                    NavigationLink(destination: SettingView(userViewModel: userViewModel), isActive: $userViewModel.showSettings) {
                        Text("").hidden()
                    }
                    .opacity(0)
                    .frame(width: 0, height: 0)
                    
                    HStack {
                        Text("Browse Categories")
                            .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                            .foregroundColor(userViewModel.isOn ? .white : .black)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                        Spacer()
                    }
                    
                    if userViewModel.showSearch {
                        if searchResults.isEmpty {
                            Color(userViewModel.isOn ? .black : .white)
                        } else {
                            List(searchResults, id: \.id) { book in
                                NavigationLink(destination: BookDetailView(userViewModel: userViewModel, bookViewModel: bookViewModel, reviewViewModel: reviewViewModel, currentBook: book), isActive: $userViewModel.showSettings){
                                    Text(book.name)
                                        .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize+2))
                                        .fontWeight(.regular)
                                }
                            }
                        }
                    }
                    else {
                        CategoryListView(userViewModel: userViewModel, bookViewModel: bookViewModel, reviewViewModel: reviewViewModel)
                            .opacity(userViewModel.showSearch ? 0 : 1)
                    }
                    
                    
                    Divider()
                }
            }
        }
        .background(userViewModel.isOn ? .black : .white)
        .onAppear {
            userViewModel.searchText = ""
            userViewModel.showSearch = false
            searchResults = bookViewModel.books
            userViewModel.isSearchBarVisible = false
        }
        .onChange(of: userViewModel.searchText) { text in
            text == "" ? searchResults = bookViewModel.books : searchAllBooks()
        }
    }
    
    // Function to perform the search
    func searchAllBooks() {
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
        BrowseView(userViewModel: UserViewModel(), bookViewModel: BookViewModel(), reviewViewModel: ReviewViewModel())
    }
}
