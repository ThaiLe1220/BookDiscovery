//
//  InputCommentView.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 15/09/2023.
//

import SwiftUI

struct InputCommentView: View {
    @Binding var content: String
    
    @State private var isStar1 = false
    @State private var isStar2 = false
    @State private var isStar3 = false
    @State private var isStar4 = false
    @State private var isStar5 = false
    
    var body: some View {
        VStack {
            HStack {
                CommentProfileView(profileImage: UIImage(named: "profile")!)
                    .frame(width: 50)
                    .padding(.horizontal)
                
                Image(systemName: isStar1 ? "star.fill" : "star")
                    .foregroundColor(isStar1 ? .yellow : .gray)
                    .gesture(
                        TapGesture(count: 1)
                            .onEnded { _ in
                                isStar1 = true
                                isStar2 = false
                                isStar3 = false
                                isStar4 = false
                                isStar5 = false
                            }
                    )
                
                Image(systemName: isStar2 ? "star.fill" : "star")
                    .foregroundColor(isStar2 ? .yellow : .gray)
                    .gesture(
                        TapGesture(count: 1)
                            .onEnded { _ in
                                isStar1 = true
                                isStar2 = true
                                isStar3 = false
                                isStar4 = false
                                isStar5 = false
                            }
                    )
                Image(systemName: isStar3 ? "star.fill" : "star")
                    .foregroundColor(isStar3 ? .yellow : .gray)
                    .gesture(
                        TapGesture(count: 1)
                            .onEnded { _ in
                                isStar1 = true
                                isStar2 = true
                                isStar3 = true
                                isStar4 = false
                                isStar5 = false
                            }
                    )
                Image(systemName: isStar4 ? "star.fill" : "star")
                    .foregroundColor(isStar4 ? .yellow : .gray)
                    .gesture(
                        TapGesture(count: 1)
                            .onEnded { _ in
                                isStar1 = true
                                isStar2 = true
                                isStar3 = true
                                isStar4 = true
                                isStar5 = false
                            }
                    )
                Image(systemName: isStar5 ? "star.fill" : "star")
                    .foregroundColor(isStar5 ? .yellow : .gray)
                    .gesture(
                        TapGesture(count: 1)
                            .onEnded { _ in
                                isStar1 = true
                                isStar2 = true
                                isStar3 = true
                                isStar4 = true
                                isStar5 = true
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
        }
    }
}

struct InputCommentView_Previews: PreviewProvider {
    static var previews: some View {
        InputCommentView(content: .constant(""))
    }
}
