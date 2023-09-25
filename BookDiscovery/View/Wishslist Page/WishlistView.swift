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

struct WishlistView: View {
    // MARK: - Variables
    @ObservedObject var userViewModel : UserViewModel
    @ObservedObject var bookViewModel: BookViewModel
    @ObservedObject var reviewViewModel: ReviewViewModel
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    @State var wishListBooks: [Book] = []
    
    // MARK: - Main View
    var body: some View {
        NavigationStack {
            VStack (spacing: 0) {
                // MARK: - Header
                HeaderView(userViewModel: userViewModel, tabName: "Wishlist")
                
                NavigationBar(userViewModel: userViewModel)
                    .padding(.top, 8)
                    .padding(.bottom, 16)
                
                HStack {
                    Text("Your Library")
                        .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                        .foregroundColor(userViewModel.isOn ? .white : .black)
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                    Spacer()
                    // MARK: - Filter
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

                // MARK: - List of Books
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
