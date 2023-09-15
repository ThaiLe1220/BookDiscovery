//
//  ImagePickerView.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 12/09/2023.
//

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
