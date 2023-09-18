//
//  InputCommentView.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 15/09/2023.
//

import SwiftUI

struct InputCommentView: View {
    @State private var content: String = ""
    @State private var numStar: Int = 0
    
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
            
            Button {
                
            } label: {
                Text("Submit")
            }
        }
    }
}

struct InputCommentView_Previews: PreviewProvider {
    static var previews: some View {
        InputCommentView()
    }
}
