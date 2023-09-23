//
//  UserReviewView.swift
//  BookDiscovery
//
//  Created by Thai, Le Hong on 22/09/2023.
//

import SwiftUI

struct UserReviewView: View {
    @ObservedObject var userViewModel : UserViewModel
    @ObservedObject var bookViewModel: BookViewModel
    @ObservedObject var reviewViewModel: ReviewViewModel
    
    var review: Review
    
    var body: some View {
        VStack (spacing: 0) {
            HStack {
                CommentView(review: review, userViewModel: userViewModel)
                    .onAppear {
                        reviewViewModel.allReviews.sort(by: {$0.date > $1.date})
                    }
            }

            HStack (spacing: 0) {
                ForEach(bookViewModel.books, id: \.self) { book in
                    if (book.id == review.bookID) {
                            NavigationLink(destination: BookDetailView(userViewModel: userViewModel, bookViewModel: bookViewModel, reviewViewModel: reviewViewModel, currentBook: book)) {
                                HStack (spacing: 0) {
                                    ZStack {
                                        Image(uiImage: book.image!)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 100)
                                    }
                                    
                                    VStack (spacing: 0) {
                                        HStack {
                                            Text(book.name)
                                                .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize-1))
                                                .fontWeight(.semibold)
                                            Spacer()
                                        }
                                        .padding(.vertical, 8)
                                        
                                        HStack {
                                            Text(book.author)
                                                .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize-2))
                                                .fontWeight(.regular)
                                                .italic()
                                            
                                            Spacer()
                                        }
                                        .padding(.vertical, 4)

                                        // Category View
                                        VStack (alignment: .leading) {
                                            ScrollView(.horizontal) {
                                                HStack {
                                                    ForEach(book.category, id: \.self) { category in
                                                        Text(category)
                                                            .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize-4))
                                                            .fontWeight(.regular)
                                                            .padding(4)
                                                            .background {
                                                                Rectangle()
                                                                    .fill(Color.random())
                                                                    .cornerRadius(4)
                                                            }
                                                    }
                                                }
                                            }
                                            .scrollIndicators(.hidden)
                                        }
                                        
                                        Spacer()

                                    }
                                    .frame(width: .infinity, height: 100)
                                    .padding(.horizontal, 8)
                                }
                            }
                    }
                }
            }
            .frame(height: 100)
        }
        .onAppear {
        }

    }
}

struct UserReviewView_Previews: PreviewProvider {
    static var previews: some View {
        UserReviewView(userViewModel: UserViewModel(), bookViewModel: BookViewModel(), reviewViewModel: ReviewViewModel(), review: testReview1)
    }
}
