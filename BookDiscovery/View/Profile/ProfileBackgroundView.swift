//
//  ProfileBackgroundView.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 13/09/2023.
//

import SwiftUI

struct ProfileBackgroundView: View {
    var bgImage: UIImage
    @State private var isShowingImagePicker = false
    
    var body: some View {
        VStack{
            Button {
                isShowingImagePicker.toggle()
            } label: {
                Image(uiImage: bgImage)
                    .resizable()
                    .clipped()
                    .frame(height: 240)
            }
        }
        .frame(height: 240)

        .sheet(isPresented: $isShowingImagePicker) {
            ImagePickerView(isPresented: $isShowingImagePicker, isProfileImage: false, selectedImage: bgImage)
        }
    }
}


struct ProfileBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileBackgroundView(bgImage: UIImage(named: "background")!)
    }
}
