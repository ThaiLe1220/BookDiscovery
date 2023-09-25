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

struct ImagePickerView: View {
    // ViewModel to manage user state
    @ObservedObject var userViewModel: UserViewModel

    @Binding var isPresented: Bool
    var isProfileImage: Bool
    @State var selectedImage: UIImage?
    
    var body: some View {
        NavigationView {
            VStack {
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                ImagePicker(selectedImage: $selectedImage)
            }
            .padding()
            .navigationBarTitle("Options", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel") {
                isPresented = false
            })
            .navigationBarItems(trailing: Button {
                isPresented = false
                if let image = selectedImage {
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

struct ImagePickerView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePickerView(userViewModel: UserViewModel(), isPresented: .constant(true), isProfileImage: (UIImage(named: "background") != nil))
    }
}
