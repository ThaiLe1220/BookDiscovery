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

struct CommentProfileView: View { // CommentProfileView displays the profile image in a circle

    var profileImage: UIImage    // The UIImage for the profile

    
    var body: some View {
        VStack {        // Main vertical stack for the view

            Image(uiImage: profileImage)
                .resizable()                // Making the image resizable

                .scaledToFit()                // Fitting the image into the defined frame

                .frame(width: 70, height: 70)                // Setting the frame size

                .clipShape(Circle())                // Clipping the image into a circle

                .overlay(                // Adding a black stroke overlay on the circle

                    Circle()
                        .stroke(Color(.black), lineWidth: 1)
                        .opacity(0.8)
                )
                .shadow(radius: 7)                // Adding shadow to the image

        }
    }
}

// Preview for CommentProfileView
struct CommentProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CommentProfileView(profileImage: UIImage(named: "profile")!)
    }
}
