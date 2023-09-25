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

// CommentView struct renders the comment UI for each review\
struct CommentView: View {
    var review: Review     // The review to display imported from the Book Review
    @ObservedObject var userViewModel: UserViewModel    // The UserViewModel to get user-specific settings, such as font

    @State private var username: String? = ""    // State variables to hold the username and user image

    @State private var userImage: UIImage = UIImage(named: "profile")!
    
    var body: some View {    // Main View body

        ZStack {        // ZStack allows overlapping of views

            VStack{            // Main vertical stack to organize components

                HStack (spacing: 0) {                // Horizontal Stack for the user profile picture and metadata

                    CommentProfileView(profileImage: userImage)                    // Profile image view to display

                        .scaleEffect(0.8)
                        .frame(width: 50, height: 50)
                        .padding(.horizontal, 8)
                    
                    VStack (alignment: .leading) {                    // Vertical stack for the username and the review date

                        HStack {                        // Username of the reviewer
                            Text((username == "" ? "empty name" : username)!)
                                .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize+1))
                                .fontWeight(.bold)
                            
                            Spacer()
                        }

                        
                        Spacer()
                        HStack {                        // Review date and rating
                            Text(review.date)
                                .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize-2))
                                .fontWeight(.regular)
                                .italic()
                            
                            Spacer()
                            
                            RatingView(rating: review.rating) // This is the ratingView of the user on the book
                                .scaleEffect(0.6)
                                .frame(width: 80)
                        }

                    }
                    .frame(width: .infinity, height: 50)
                }
                .frame(height: 50)
                .padding(.top, 8)
                
                HStack () {                // Under them all, this is to display user's comment on the book

                    Text(review.comment)
                        .multilineTextAlignment(.leading)
                        .padding(8)
                        .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                        .fontWeight(.regular)
                    Spacer()
                }
                .padding(.vertical, 4)
            }
            .background {            // Background color for the view
                VStack {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(userViewModel.isOn ? .black : .white)
                }
            }
        }
        .onAppear {        // Fetching the username and profile image on appear
            FireBaseDB().fetchUserNameBy(userID: review.userID) { username in
                DispatchQueue.main.async { // Async waiting for the data
                    if let username = username {
                        self.username = username
                    }
                }
            }
            ImageStorage().getProfileWithId(userId: review.userID) { image in
                DispatchQueue.main.async {// Async waiting for the data
                    if let userimg = image {
                        userImage = userimg
                    }
                }
            }
        }
    }
}
// Preview for the CommentView

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView(review: testReview1, userViewModel: UserViewModel())
    }
}
