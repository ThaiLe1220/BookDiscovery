//
//  ProfileImageView.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 12/09/2023.
//

import SwiftUI
import UIKit

struct ProfileImageView: View {
    var profileImage: UIImage
    
    @State private var isShowingImagePicker = false
            
    var body: some View {
        VStack {
            Button {
                isShowingImagePicker.toggle()
            } label: {
                Image(uiImage: profileImage)
                    .resizable()
                    .scaledToFit()
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
            ImagePickerView(isPresented: $isShowingImagePicker, isProfileImage: true, selectedImage: profileImage)
        }
    }
}
