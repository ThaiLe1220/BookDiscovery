//
//  InputCommentView.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 15/09/2023.
//

import SwiftUI
import Firebase

struct InputCommentView: View {
    var bookID: String
    
    @State private var content: String = ""
    @State private var numStar: Int = 0
    @State private var announcement: String = ""
    @State private var isError: Bool = true
    
    
    var completion: (Review?) -> Void
    
    
    
    var body: some View {
        VStack {
            HStack {
                CommentProfileView(profileImage: UIImage(named: "profile")!)
                    .frame(width: 50)
                    .padding(.horizontal)
                
                Image(systemName: numStar >= 1  ? "star.fill" : "star")
                    .foregroundColor(numStar >= 1 ? .yellow : .gray)
                    .gesture(
                        TapGesture(count: 1)
                            .onEnded { _ in
                                announcement = ""
                                if numStar == 1 {
                                    numStar = 0
                                } else {
                                    numStar = 1
                                }
                            }
                    )
                
                Image(systemName: numStar >= 2 ? "star.fill" : "star")
                    .foregroundColor(numStar >= 2 ? .yellow : .gray)
                    .gesture(
                        TapGesture(count: 1)
                            .onEnded { _ in
                                announcement = ""
                                if numStar == 2 {
                                    numStar = 0
                                } else {
                                    numStar = 2
                                }
                            }
                    )
                Image(systemName: numStar >= 3 ? "star.fill" : "star")
                    .foregroundColor(numStar >= 3 ? .yellow : .gray)
                    .gesture(
                        TapGesture(count: 1)
                            .onEnded { _ in
                                announcement = ""
                                if numStar == 3 {
                                    numStar = 0
                                } else {
                                    numStar = 3
                                }
                            }
                    )
                Image(systemName: numStar >= 4 ? "star.fill" : "star")
                    .foregroundColor(numStar >= 4 ? .yellow : .gray)
                    .gesture(
                        TapGesture(count: 1)
                            .onEnded { _ in
                                announcement = ""
                                if numStar == 4 {
                                    numStar = 0
                                } else {
                                    numStar = 4
                                }
                            }
                    )
                Image(systemName: numStar >= 5 ? "star.fill" : "star")
                    .foregroundColor(numStar >= 5 ? .yellow : .gray)
                    .gesture(
                        TapGesture(count: 1)
                            .onEnded { _ in
                                announcement = ""
                                if numStar == 5 {
                                    numStar = 0
                                } else {
                                    numStar = 5
                                }
                            }
                    )
                
                Spacer()
            }
            .padding(.horizontal)
            
            Divider()
            
            TextEditor(text: $content)
                .frame(minHeight: 100)
                .border(.gray, width: 2)
                .padding(.horizontal)
                .onChange(of: content) { newValue in
                    announcement = ""
                }
            
            HStack {
                Text(announcement)
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
                            } else {
                                completion(nil)
                            }
                        }
                    }
                } label: {
                    Text("Send")
                }
                .padding(.horizontal)
            }
        }
    }
}
