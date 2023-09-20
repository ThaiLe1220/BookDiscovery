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
    @State private var searchResults: [Book] = []
    var currentBook: Book
    
    var body: some View {
        NavigationStack {
            VStack {
                NavigationBar(userViewModel: userViewModel, performSearch: performSearch)
               
                // Display search results
               List(searchResults, id: \.id) { book in
                   Text(book.name)
               }
                
                Spacer()
                NavigationLink(destination: SettingView(isOn: $isOn, userViewModel: userViewModel), isActive: $userViewModel.showSettings) {
                    Text("").hidden()
                }
                .opacity(0)
                .frame(width: 0, height: 0)
            }
            
        }
    }
    
    // Function to perform the search
    private func performSearch() {
        print("Search query sent: \(userViewModel.searchText)")
        
        FireBaseDB().searchBooks(query: userViewModel.searchText) { results in
            if let results = results {
                searchResults = results
                if results.isEmpty {
                    print("No books found for query: \(userViewModel.searchText)")
                } else {
                    print("Books found for query: \(userViewModel.searchText)")
                }
            } else {
                print("Error occurred while fetching books.")
            }
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
        SearchView(isOn: .constant(false), userViewModel: UserViewModel())
    }
}
