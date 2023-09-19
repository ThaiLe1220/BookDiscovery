//
//  WishlistView.swift
//  BookDiscovery
//
//  Created by Thai, Le Hong on 14/09/2023.
//

import SwiftUI

struct WishlistView: View {
    @ObservedObject var userViewModel : UserViewModel
    @ObservedObject var bookViewModel: BookViewModel
    @ObservedObject var reviewViewModel: ReviewViewModel
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var wishListBooks : [Book] {
        
        var list : [Book] = []
        for bookId in userViewModel.currentUser.wishlist {
            for book in bookViewModel.books {
                if (bookId == book.id) {
                    list.append(book)
                }
            }
        }
        return list
    }
    var body: some View {
        NavigationStack {
            VStack {
//                NavigationBar(userViewModel: userViewModel)
                
                LazyVGrid(columns: columns, spacing: 15) {
                    // Only display 10 books at once
                    ForEach(wishListBooks, id: \.self) { tempBook in
                        Button(action: {
//
                        }) {
                            NavigationLink(destination: BookDetailView(userViewModel: userViewModel, bookViewModel: bookViewModel, reviewViewModel: reviewViewModel, currentBook: tempBook)) {
                                VStack {
                                    BookView(book: tempBook)

                                    Spacer()
                                }
                                
                            }
                        }
                    }
                }
                .background(GeometryReader {
                    Color.clear.preference(key: ViewOffsetKey.self,
                                           value: -$0.frame(in: .named("scrollView")).origin.y)
                })
                
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
        WishlistView(userViewModel: UserViewModel(), bookViewModel: BookViewModel(), reviewViewModel: ReviewViewModel())
    }
}
