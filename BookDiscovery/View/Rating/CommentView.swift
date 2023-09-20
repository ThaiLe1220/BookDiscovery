//
//  CommentView.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 13/09/2023.
//

import SwiftUI

struct CommentView: View {
    @Binding var isOn: Bool
    var review: Review
    @ObservedObject var userViewModel: UserViewModel
    @State private var username: String? = ""
    
    var body: some View {
        ZStack {
            VStack{
                HStack{
                    HStack {
                        CommentProfileView(profileImage: UIImage(named: "profile")!)
                            .frame(width: 65)
                            .padding(.horizontal)
                        Text(username!)
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
                        .padding(.bottom)
                        .padding(.horizontal)
                    Spacer()
                }
            }
            .background {
                VStack {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(isOn ? .black : .white)
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
        }
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView(isOn: .constant(false), review: testReview1, userViewModel: UserViewModel())
    }
}
