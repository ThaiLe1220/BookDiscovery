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

struct CommentProfileView: View {
    var profileImage: UIImage
    
    var body: some View {
        VStack {
            Image(uiImage: profileImage)
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color(.black), lineWidth: 1)
                        .opacity(0.8)
                )
                .shadow(radius: 7)
        }
    }
}


struct CommentProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CommentProfileView(profileImage: UIImage(named: "profile")!)
    }
}
