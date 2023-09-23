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

    @State var wishListBooks: [Book] = []
    
    var body: some View {
        NavigationStack {
            VStack (spacing: 0) {
                HeaderView(userViewModel: userViewModel, tabName: "Wishlist")
                
                NavigationBar(userViewModel: userViewModel)
                    .padding(.top, 8)
                    .padding(.bottom, 16)
                
                NavigationLink(destination: SettingView(userViewModel: userViewModel), isActive: $userViewModel.showSettings) {
                    Text("").hidden()
                }
                .opacity(0)
                .frame(width: 0, height: 0)
                
                HStack {
                    Text("Your Library")
                        .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                        .foregroundColor(userViewModel.isOn ? .white : .black)
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                    Spacer()
                    Menu {
                        Menu {
                            Button {
                                wishListBooks.sort(by: {$0.rating < $1.rating})
                            } label: {
                                HStack {
                                    Text("Ascending")
                                }
                            }
                            
                            Button {
                                wishListBooks.sort(by: {$0.rating > $1.rating})
                            } label: {
                                HStack {
                                    Text("Descending")
                                }
                            }

                        } label: {
                            HStack {
                                Text("Rating")
                            }
                        }

                        Menu {
                            Button {
                                wishListBooks.sort(by: {$0.name < $1.name})
                            } label: {
                                HStack {
                                    Text("A-Z")
                                }
                            }
                            Button {
                                wishListBooks.sort(by: {$0.name > $1.name})
                            } label: {
                                HStack {
                                    Text("Z-A")
                                }
                            }

                        } label: {
                            HStack {
                                Text("Name")
                            }
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(Color("OrangeMain"))
                            .padding(.horizontal)
                    }
                }
                .frame(height: 25)

                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 15) {
                        // Only display 10 books at once
                        ForEach(wishListBooks, id: \.self) { book in
                            Button(action: {
                                //
                            }) {
                                NavigationLink(destination: BookDetailView(userViewModel: userViewModel, bookViewModel: bookViewModel, reviewViewModel: reviewViewModel, currentBook: book)) {
                                    VStack {
                                        BookView(userViewModel: userViewModel, book: book)
                                        Spacer()
                                    }
                                    
                                }
                            }
                        }
                    }
                }
                Spacer()
                Divider()

            }
            
        }
        .onAppear {

            self.wishListBooks = []
            for bookID in userViewModel.currentUser.wishlist {
                self.wishListBooks.append(bookViewModel.get(bookID: bookID))
            }
        }
        .onChange(of: userViewModel.currentUser.wishlist) { _ in
            self.wishListBooks = []
            for bookID in userViewModel.currentUser.wishlist {
                self.wishListBooks.append(bookViewModel.get(bookID: bookID))
            }
        }
    }
}

struct WishlistView_Previews: PreviewProvider {
    static var previews: some View {
        WishlistView(userViewModel: UserViewModel(), bookViewModel: BookViewModel(), reviewViewModel: ReviewViewModel())
    }
}
