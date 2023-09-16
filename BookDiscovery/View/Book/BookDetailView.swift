//
//  BookDetailView.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 15/09/2023.
//

import SwiftUI

struct BookDetailView: View {
    @ObservedObject var bookViewModel: BookViewModel
    @ObservedObject var reviewViewModel: ReviewViewModel
    
    @State var inWishList: Bool = false
    
    @State private var tabOverview: Bool = true
    @State private var tabDetail: Bool = false
    @State private var tabReview: Bool = false
    
    
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
                    ForEach(reviewViewModel.reviews, id: \.id) { review in
                        CommentView(review: review)
                    }
                }
            }
        }
        .onAppear {
            print(bookViewModel.currentBook)
        }
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView(bookViewModel: BookViewModel(), reviewViewModel: ReviewViewModel())
    }
}
