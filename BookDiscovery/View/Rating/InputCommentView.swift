//
//  InputCommentView.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 15/09/2023.
//

import SwiftUI
import Firebase

struct InputCommentView: View {
    @ObservedObject var userViewModel: UserViewModel
    @ObservedObject var reviewViewModel: ReviewViewModel

    var bookID: String
    
    var currentBook: Book
    @State private var content: String = ""
    @State private var numStar: Int = 0
    @State private var announcement: String = ""
    @State private var isError: Bool = true
    
    
    var completion: (Review?) -> Void
    var body: some View {
        VStack {
            VStack{
                HStack{
                    Rectangle()
                        .fill(.gray)
                        .frame(width: 70, height: 5)
                        .cornerRadius(2)
                }
                Divider()
            }
            
            VStack {
                Spacer()
                VStack {
                    HStack {
                        Text(currentBook.name)
                            .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                            .fontWeight(.regular)
                        Spacer()
                        ForEach(1..<6) { i in
                            Image(systemName: numStar >= i  ? "star.fill" : "star")
                                .foregroundColor(numStar >= i ? .yellow : .gray)
                                .gesture(
                                    TapGesture(count: 1)
                                        .onEnded { _ in
                                            announcement = ""
                                            if numStar == i {
                                                numStar = 0
                                            } else {
                                                numStar = i
                                            }
                                        }
                                )
                        }
                    }
                    HStack {
                        Text(currentBook.author)
                            .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize+4))
                            .fontWeight(.bold)
                        Spacer()
                    }
                    HStack {
                        Text("Write down your experience below:")
                            .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                            .fontWeight(.regular)
                        Spacer()
                    }
                }
                Spacer()
                TextEditor(text: $content)
                    .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize+4))
                    .fontWeight(.regular)
                    .frame(minHeight: 100)
                    .border(.gray, width: 1)
                    .onChange(of: content) { newValue in
                        announcement = ""
                    }
                
                HStack {
                    Text(announcement)
                        .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                        .fontWeight(.regular)
                        .padding(.horizontal)
                        .foregroundColor(isError ? .red : .green)
                    
                    Spacer()
                    
                    Button {
                        if numStar == 0 || content == "" {
                            announcement = "Invalid!"
                            isError = true
                            return
                        }
                        
                        if let userID = Auth.auth().currentUser?.uid {
                            FireBaseDB().addReview(userID: userID, bookID: bookID, rating: Double(numStar), comment: content) { success in
                                if let review = success {
                                    content = ""
                                    numStar = 0
                                    announcement = "Successful!"
                                    isError = false
                                    completion(review)
                                    reviewViewModel.currentBookReviews.append(review)
                                    reviewViewModel.allReviews.append(review)
                                } else {
                                    completion(nil)
                                }
                            }
                        }
                        

                    } label: {
                        Text("Send")
                            .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                            .fontWeight(.regular)
                    }
                }
            }
        }
    }
}
