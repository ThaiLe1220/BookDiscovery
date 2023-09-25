/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author/Group: 3 - Book Discovery
  Created  date: 13/09/2023
  Last modified: 25/09/2023
  Acknowledgement: N/A
*/

import SwiftUI

struct CommentView: View {
    var review: Review
    @ObservedObject var userViewModel: UserViewModel
    @State private var username: String? = ""
    @State private var userImage: UIImage = UIImage(named: "profile")!
    
    var body: some View {
        ZStack {
            VStack{
                HStack (spacing: 0) {
                    CommentProfileView(profileImage: userImage)
                        .scaleEffect(0.8)
                        .frame(width: 50, height: 50)
                        .padding(.horizontal, 8)
                    
                    VStack (alignment: .leading) {
                        HStack {
                            Text((username == "" ? "empty name" : username)!)
                                .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize+1))
                                .fontWeight(.bold)
                            
                            Spacer()
                        }

                        
                        Spacer()
                        HStack {
                            Text(review.date)
                                .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize-2))
                                .fontWeight(.regular)
                                .italic()
                            
                            Spacer()
                            
                            RatingView(rating: review.rating)
                                .scaleEffect(0.6)
                                .frame(width: 80)
                        }

                    }
                    .frame(width: .infinity, height: 50)
                }
                .frame(height: 50)
                .padding(.top, 8)
                
                HStack () {
                    Text(review.comment)
                        .multilineTextAlignment(.leading)
                        .padding(8)
                        .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                        .fontWeight(.regular)
                    Spacer()
                }
                .padding(.vertical, 4)
            }
            .background {
                VStack {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(userViewModel.isOn ? .black : .white)
                }
            }
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
