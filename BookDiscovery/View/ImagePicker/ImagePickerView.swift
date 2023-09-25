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

/*
    This view is to let user to pick their own perferred image
 */
struct ImagePickerView: View {
    // ViewModel to manage user state
    @ObservedObject var userViewModel: UserViewModel

    @Binding var isPresented: Bool     // Binding variable to control the presentation state of this View

    var isProfileImage: Bool     // A Boolean to check if the selected image will be used as a profile image

    @State var selectedImage: UIImage?     // State variable to hold the selected image

    // The body of the SwiftUI View
    var body: some View {
        NavigationView {
            VStack {
                if let image = selectedImage {                 // Show the selected image if available

                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                ImagePicker(selectedImage: $selectedImage)                // Show the ImagePicker

            }
            .padding()
            .navigationBarTitle("Options", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel") {            // Cancel button to dismiss the view

                isPresented = false
            })
            .navigationBarItems(trailing: Button {            // Done button to finalize the image selection

                isPresented = false
                if let image = selectedImage {                // Upload the selected image based on whether it's a profile or background image

                    if isProfileImage {
                        ImageStorage().uploadProfile(image: image)
                        userViewModel.userImage = image
                    } else {
                        ImageStorage().uploadBackground(image: image)
                        userViewModel.userBGImage = image

                    }
                }
            } label: {
                if let _ = selectedImage {
                    Text("Done")
                        .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                        .fontWeight(.regular)
                }
            })
        }
    }
}

// SwiftUI Preview
struct ImagePickerView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePickerView(userViewModel: UserViewModel(), isPresented: .constant(true), isProfileImage: (UIImage(named: "background") != nil))
    }
}
