/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author/Group: 3 - Book Discovery
  Created  date: 12/09/2023
  Last modified: 25/09/2023
  Acknowledgement: N/A
*/

import SwiftUI
import UIKit

// UserSignUpView is responsible for handling user registration
struct ProfileImageView: View {
    // ViewModel to manage user state
    @ObservedObject var userViewModel: UserViewModel
    @State private var isShowingImagePicker = false
            
    var body: some View {
        ZStack {
            Image(uiImage: userViewModel.userImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 130, height: 130)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color(.white), lineWidth: 4)
                        .opacity(0.8)
                )
                .shadow(radius: 7)
            
            Button {
                isShowingImagePicker.toggle()
            } label: {
                Circle()
                    .fill(Color.white)
                    .frame(width: 28, height: 28) // Adjust the size as needed
                    .overlay(
                        Image(systemName: "camera")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(.black) // Customize the image color
                    )
            }
            .offset(x: 45, y: 45)
        }
        .sheet(isPresented: $isShowingImagePicker) {
            ImagePickerView(userViewModel: userViewModel, isPresented: $isShowingImagePicker, isProfileImage: true, selectedImage: userViewModel.userImage)
        }
    }
}

struct ProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImageView(userViewModel: UserViewModel())
    }
}
