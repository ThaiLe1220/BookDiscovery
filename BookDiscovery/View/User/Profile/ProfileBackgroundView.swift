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

struct ProfileBackgroundView: View {
    // ViewModel to manage user state
    @ObservedObject var userViewModel: UserViewModel
    @State private var isShowingImagePicker = false
    
    var body: some View {
        VStack{
            Button {
                isShowingImagePicker.toggle()
            } label: {
                Image(uiImage: userViewModel.userBGImage)
                    .resizable()
                    .clipped()
                    .frame(height:180)
            }
        }
        .frame(height: 180)
        .sheet(isPresented: $isShowingImagePicker) {
            ImagePickerView(userViewModel: userViewModel, isPresented: $isShowingImagePicker, isProfileImage: false, selectedImage: userViewModel.userBGImage)
        }
    }
}


struct ProfileBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileBackgroundView(userViewModel: UserViewModel())
    }
}
