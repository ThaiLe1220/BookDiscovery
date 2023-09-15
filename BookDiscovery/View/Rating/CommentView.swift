//
//  CommentView.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 13/09/2023.
//

import SwiftUI

struct CommentView: View {
    var review: Review
    
    var body: some View {
        VStack {
            HStack{
                CommentProfileView(profileImage: UIImage(named: "profile")!)
                    .frame(width: 65)
                    .padding(.horizontal)
                    .offset(y: 5)
                
                VStack{
                    Text(review.userID)
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
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView(review: testReview1)
    }
}
