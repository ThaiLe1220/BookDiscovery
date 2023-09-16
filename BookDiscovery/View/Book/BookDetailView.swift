//
//  BookDetailView.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 15/09/2023.
//

import SwiftUI

struct BookDetailView: View {
    var book: Book = testBook
    
    @State var inWishList: Bool = false
    

    @StateObject var reviewViewModel: ReviewViewModel = ReviewViewModel()
    
    @State private var tabOverview: Bool = true
    @State private var tabDetail: Bool = false
    @State private var tabReview: Bool = false
    
    
    var body: some View {
        ScrollView {
            VStack {
                ZStack {
                    Color(.gray)
                        .opacity(0.2)
                    Image("thumbnail")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                    
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
                                Text(book.name)
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
                        RatingView(rating: book.rating)
                            .frame(width: 150)
                        Text(String(book.rating))
                        Spacer()
                    }
                    .padding()

                    HStack {
                        Text("Category: ")
                            .padding(.horizontal)
                            .bold()
                        ForEach(book.category, id: \.self) { category in
                            Text(category)
                        }
                        Spacer()
                    }
                    .padding(.bottom, 15)
                    
                    HStack {
                        Text("Author:")
                            .padding(.horizontal)
                            .bold()
                        Text(book.author.name)
                            .padding(.horizontal)
                        Spacer()
                    }
                    
                    Text(book.headline)
                        .padding()
                        .lineSpacing(15)
                }
                
                
                if tabDetail {
                    Text(book.description)
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
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView()
    }
}
