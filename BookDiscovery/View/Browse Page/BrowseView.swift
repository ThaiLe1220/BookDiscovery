/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author/Group: 3 - Book Discovery
  Created  date: 14/09/2023
  Last modified: 25/09/2023
  Acknowledgement: N/A
*/

import SwiftUI

struct BrowseView: View {
    // MARK: - Variables
    @ObservedObject var userViewModel: UserViewModel
    @ObservedObject var bookViewModel: BookViewModel
    @ObservedObject var reviewViewModel: ReviewViewModel
    @State var scrollOffset: CGFloat = 0.0
    @State var showTitle: Bool = false
    
    @State var searchResults: [Book] = []

    // MARK: - Main View
    var body: some View {
        NavigationStack {
            VStack (spacing: 0) {
                // MARK: - Header
                HeaderView(userViewModel: userViewModel, tabName: "Search")
                
                // MARK: - Search bar
                NavigationBar(userViewModel: userViewModel)
                    .padding(.top, 8)
                    .padding(.bottom, 16)
                
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
                        // MARK: - List of books
                        List(searchResults, id: \.id) { book in
                            NavigationLink(destination: BookDetailView(userViewModel: userViewModel, bookViewModel: bookViewModel, reviewViewModel: reviewViewModel, currentBook: book), isActive: $userViewModel.showSettings){
                                Text(book.name)
                                    .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize+2))
                                    .fontWeight(.regular)
                                    .onTapGesture {
                                        userViewModel.currentUser.searchHistory.append(book.name)
                                        
                                        FireBaseDB().updateUser(user: userViewModel.currentUser) { success, error in
                                            if success {
                                                print("search query added to search history")
                                            } else {
                                                print(error?.localizedDescription ?? "Unknown Error")
                                            }
                                        }
                                    }
                            }
                        }
                    }
                }
                else {
                    // MARK: - List of category
                    CategoryListView(userViewModel: userViewModel, bookViewModel: bookViewModel, reviewViewModel: reviewViewModel)
                        .opacity(userViewModel.showSearch ? 0 : 1)
                }
                
                
                Divider()
            }
      
        }
        .background(userViewModel.isOn ? .black : .white)
        .onAppear {
            userViewModel.showSearch = false
            userViewModel.isSearchBarVisible = false
            userViewModel.searchText = ""
            searchResults = bookViewModel.books

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
    }
}

struct BrowseView_Previews: PreviewProvider {
    static var previews: some View {
        BrowseView(userViewModel: UserViewModel(), bookViewModel: BookViewModel(), reviewViewModel: ReviewViewModel())
    }
}
