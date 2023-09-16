//
//  ProfileBackgroundView.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 13/09/2023.
//

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
