//
//  UserReviewView.swift
//  BookDiscovery
//
//  Created by Thai, Le Hong on 22/09/2023.
//

import SwiftUI

struct UserReviewView: View {
    @Binding var isOn: Bool

    @ObservedObject var userViewModel : UserViewModel
    @ObservedObject var bookViewModel: BookViewModel
    @ObservedObject var reviewViewModel: ReviewViewModel
    
    var review: Review
    
    var body: some View {
        VStack {
            HStack{
                CommentView(isOn: $isOn, review: review, userViewModel: userViewModel)
                    .onAppear {
                        reviewViewModel.allReviews.sort(by: {$0.date > $1.date})
                    }
            }
            
            HStack {
                ForEach(bookViewModel.books, id: \.self) { book in
                    if (book.id == review.bookID) {
                            NavigationLink(destination: BookDetailView(isOn: $isOn, userViewModel: userViewModel, bookViewModel: bookViewModel, reviewViewModel: reviewViewModel, currentBook: book)) {
                                HStack {
                                    VStack {
                                        Image(uiImage: book.image!)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 64)
                                    }
                                    Spacer()
                                    VStack {
                                        Text(book.name)
                                            .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize+1))
                                            .fontWeight(.semibold)
                                        
                                        Text(book.author.name)
                                            .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize-1))
                                            .fontWeight(.regular)
                                    }

                                    Spacer()
                                }
                                
                            }
                    }
                }
            }
        }
        .onAppear {
        }

    }
}

struct UserReviewView_Previews: PreviewProvider {
    static var previews: some View {
        UserReviewView(isOn: .constant(false), userViewModel: UserViewModel(), bookViewModel: BookViewModel(), reviewViewModel: ReviewViewModel(), review: ReviewViewModel().allReviews[0])
    }
}
