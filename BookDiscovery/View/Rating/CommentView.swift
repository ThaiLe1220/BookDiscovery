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
    @State private var userImage: UIImage = UIImage(named: "profile")!
    
    var body: some View {
        ZStack {
            VStack{
                HStack{
                    HStack {
                        CommentProfileView(profileImage: userImage)
                            .frame(width: 65)
                            .padding(.horizontal)
                        Text(username!)
                            .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                            .fontWeight(.regular)
                    }
                    .offset(y: -20)
                    Spacer()
                    HStack{
                        RatingView(rating: review.rating)
                            .frame(width: 100)
                    }
                    .offset(y: -20)
                    .padding(.horizontal)
                }
                HStack{
                    Text(review.comment)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal)
                        .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                        .fontWeight(.regular)
                    Spacer()
                }
                HStack {
                    Spacer()
                    Text(review.date)
                        .padding(.bottom)
                        .padding(.horizontal)
                        .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                        .fontWeight(.regular)
                }
            }
            .background {
                VStack {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(userViewModel.isOn ? .black : .white)
                }
            }
            .padding()
        }
        .onAppear {
            FireBaseDB().fetchUserNameBy(userID: review.userID) { username in
                DispatchQueue.main.async {
                    if let username = username {
                        self.username = username
                    }
                }
            }
            ImageStorage().getProfileWithId(userId: review.userID) { image in
                DispatchQueue.main.async {
                    if let userimg = image {
                        userImage = userimg
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
