//
//  BookDetailView.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 15/09/2023.
//

import SwiftUI

struct BookDetailView: View {
    @ObservedObject var userViewModel: UserViewModel
    @ObservedObject var bookViewModel: BookViewModel
    @ObservedObject var reviewViewModel: ReviewViewModel
    var currentBook: Book
    
    @State var inWishList: Bool = false
    
    
    @State private var tabOverview: Bool = true
    @State private var tabDetail: Bool = false
    @State private var tabReview: Bool = false
    
    @State private var selectedOption = 0
    
    var body: some View {
        ScrollView {
            VStack {
                ZStack {
                    Color(.gray)
                        .opacity(0.2)
                    
                    if let imageURL = bookViewModel.currentBook.imageURL {
                        AsyncImage(url: imageURL) { phase in
                            switch phase {
                            case .empty:
                                Text("LOADING\nCOVER IMAGE")
                                
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                
                            case .failure:
                                Image("cover_unavailable")
                                    .resizable()
                                    .scaledToFit()
                                
                            @unknown default:
                                // Handle unknown cases
                                Text("WTF HAPPENED")
                            }
                        }
                        .frame(width: 240, height: 380)
                    } else {
                        Image("thumbnail")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 240, height: 320)
                    }
                    
                    VStack {
                        HStack {
                            Spacer()
                            Button {
                                inWishList.toggle()
                                if (inWishList) {
                                    userViewModel.currentUser.wishlist.append(currentBook.id)
                                    FireBaseDB().updateUser(user: userViewModel.currentUser) { (success, error) in
                                        if success {
                                            print("User updated data successfully")
                                        } else {
                                            print (error?.localizedDescription ?? "Unknown error")
                                        }
                                    }
                                }
                                else {
                                    if let index = userViewModel.currentUser.wishlist.firstIndex(of: currentBook.id) {
                                        userViewModel.currentUser.wishlist.remove(at: index)
                                    }
                                    FireBaseDB().updateUser(user: userViewModel.currentUser) { (success, error) in
                                        if success {
                                            print("User updated data successfully")
                                        } else {
                                            print (error?.localizedDescription ?? "Unknown error")
                                        }
                                    }
                                }
                            } label: {
                                Image(systemName: inWishList ? "minus.square" : "plus.square")
                                    .foregroundColor(inWishList ? .red : .green)
                                    .padding()
                                    .font(.system(size: 25))
                            }
                        }
                        Spacer()
                        HStack {
                            Spacer()
                            if inWishList {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                    .font(.system(size: 20))
                                    .padding(.horizontal)
                            }
                        }
                        ZStack {
                            Rectangle()
                                .foregroundColor(.red)
                                .frame(height: 50)
                                .opacity(0.9)
                            HStack {
                                Text(bookViewModel.currentBook.name)
                                    .foregroundColor(.white)
                                    .bold()
                            }
                        }
                    }
                }
                
                
                HStack {
                    Button {
                        tabOverview = true
                        tabDetail = false
                        tabReview = false
                    } label: {
                        Text("Overview")
                            .foregroundColor(tabOverview ? .black : .gray)
                            .bold(tabOverview)
                            .padding(.horizontal)
                    }
                    Button {
                        tabOverview = false
                        tabDetail = true
                        tabReview = false
                    } label: {
                        Text("Book Details")
                            .foregroundColor(tabDetail ? .black : .gray)
                            .bold(tabDetail)
                            .padding(.horizontal)
                    }
                    Button {
                        tabOverview = false
                        tabDetail = false
                        tabReview = true
                    } label: {
                        Text("Reviews (\(reviewViewModel.reviews.count))")
                            .foregroundColor(tabReview ? .black : .gray)
                            .bold(tabReview)
                            .padding(.horizontal)
                    }
                }
                .padding(.vertical, 10)
                
                Divider()
                
                if tabOverview {
                    HStack {
                        Text("Rating: ")
                            .bold()
                        RatingView(rating: bookViewModel.currentBook.rating)
                            .frame(width: 150)
                        Text(String(bookViewModel.currentBook.rating))
                        Spacer()
                    }
                    .padding()
                    
                    HStack {
                        Text("Category: ")
                            .padding(.horizontal)
                            .bold()
                        ForEach(bookViewModel.currentBook.category, id: \.self) { category in
                            Text(category)
                        }
                        Spacer()
                    }
                    .padding(.bottom, 15)
                    
                    HStack {
                        Text("Author:")
                            .padding(.horizontal)
                            .bold()
                        Text(bookViewModel.currentBook.author.name)
                            .padding(.horizontal)
                        Spacer()
                    }
                    
                    Text(bookViewModel.currentBook.headline)
                        .padding()
                        .lineSpacing(15)
                }
                
                
                if tabDetail {
                    Text((bookViewModel.currentBook.description))
                        .padding()
                        .lineSpacing(15)
                }
                
                if tabReview {
                    InputCommentView(bookID: bookViewModel.currentBook.id ?? "") { result in
                        if let review = result {
                            reviewViewModel.reviews.append(review)
                        }
                    }
                    .padding()
                    
                    Divider()
                    
                    HStack {
                        Text("Average: ")
                            .padding(.leading, 30)
                        Text(reviewViewModel.getAvg())
                        
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        
                        Spacer()
                        
                        Picker("Select an option", selection: $selectedOption) {
                            ForEach(0...5, id: \.self) { index in
                                if index == 0 {
                                    Text("All")
                                } else {
                                    Text(String(repeating: "★", count: 6-index))
                                        .font(.largeTitle)
                                }
                            }
                        }
                        .pickerStyle(DefaultPickerStyle())
                        .padding()
                    }
                    
                    
                    VStack {
                        Spacer()
                        Button{
                            if let amazonURL = URLCaller(name: bookViewModel.currentBook.name).amazonURL() {
                                UIApplication.shared.open(amazonURL)
                            }
                        } label: {
                            if !tabReview {
                                ZStack {
                                    Rectangle()
                                        .edgesIgnoringSafeArea(.all)
                                        .foregroundColor(Color("Amazon-Orange"))
                                        .frame(height: 30)
                                    Text("Buy On Amazon")
                                        .offset(y: 10)
                                        .foregroundColor(.black)
                                        .bold()
                                }
                            }
                        }
                    }
                }
            }
            .onAppear {
                bookViewModel.currentBook = currentBook
                print(bookViewModel.currentBook)
                reviewViewModel.getReviews(bookID: currentBook.id)
                for wishlistid in userViewModel.currentUser.wishlist {
                    if (currentBook.id == wishlistid) {
                        inWishList = true
                    }
                }
            }
        }
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView(userViewModel: UserViewModel(), bookViewModel: BookViewModel(), reviewViewModel: ReviewViewModel(), currentBook: emptyBook)
    }
}
