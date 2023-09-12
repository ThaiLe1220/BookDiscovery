//
//  ProfileImageView.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 12/09/2023.
//

import SwiftUI

struct ProfileImageView: View {
    var image : String
    
    @State private var isShowingImagePicker = false
    @State private var isShowingImage = false
    @State private var selectedImage: Image?
            
    var body: some View {
        VStack {
            Button {
                isShowingImagePicker.toggle()
            } label: {
                Image(image == "" ? "profile" : image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 100)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color(.blue), lineWidth: 1)
                            .opacity(0.8)
                    )
                    .shadow(radius: 7)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .sheet(isPresented: $isShowingImagePicker) {
            ImagePickerView(selectedImage: $selectedImage, isShowingImagePicker: $isShowingImagePicker)
        }
    }
}

struct ProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImageView(image: "")
    }
}
