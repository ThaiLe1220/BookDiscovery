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
    
    @State private var selectedOption = 0
    
    
    var body: some View {
        ZStack {
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
                            
                            
                            Spacer()
                        }
                        
                        VStack {
                            ForEach(book.category, id: \.self) { category in
                                Text(category)
                            }
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
                        
                        InputCommentView(bookID: book.id) { result in
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
                        
                        
                        if reviewViewModel.reviews.count == 0 {
                            Text("No reviews yet!")
                        } else {
                            ForEach(reviewViewModel.reviews, id: \.id) { review in
                                if selectedOption == 0 {
                                    CommentView(review: review)
                                } else {
                                    switch review.rating {
                                    case 1:
                                        if selectedOption == 5 {
                                            CommentView(review: review)
                                        }
                                    case 2:
                                        if selectedOption == 4 {
                                            CommentView(review: review)
                                        }
                                    case 3:
                                        if selectedOption == 3 {
                                            CommentView(review: review)
                                        }
                                    case 4:
                                        if selectedOption == 2 {
                                            CommentView(review: review)
                                        }
                                    case 5:
                                        if selectedOption == 1 {
                                            CommentView(review: review)
                                        }
                                    default:
                                        EmptyView()
                                    }
                                }
                            }
                        }
                        
                    }
                }
            }
            
            VStack {
                Spacer()
                Button{
                    if let amazonURL = URLCaller(name: book.name).amazonURL() {
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
        
        
        .onAppear {
            reviewViewModel.getReviews(bookID: book.id)
        }
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView()
    }
}
