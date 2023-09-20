//
//  CommentView.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 13/09/2023.
//

import SwiftUI

struct CommentView: View {
    var review: Review
    @ObservedObject var userViewModel: UserViewModel
    @State private var username: String? = ""
    
    
    var body: some View {
        VStack {
            HStack{
                CommentProfileView(profileImage: UIImage(named: "profile")!)
                    .frame(width: 65)
                    .padding(.horizontal)
                    .offset(y: 5)
                
                VStack{
                    Text(username!)
                    RatingView(rating: review.rating)
                        .frame(width: 100)
                }
                .padding(.horizontal)
                Spacer()
            }
            
            Text(review.comment)
                .multilineTextAlignment(.leading)
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 2)
        )
        .padding()
        .onAppear {
            FireBaseDB().fetchUserNameBy(userID: review.userID) { username in
                DispatchQueue.main.async {
                    if let username = username {
                        self.username = username
                    }
                }
                 
            }
        }
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView(review: testReview1, userViewModel: UserViewModel())
    }
}
