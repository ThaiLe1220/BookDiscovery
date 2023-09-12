//
//  ImagePickerView.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 12/09/2023.
//

import SwiftUI

struct ImagePickerView: View {
    @Binding var selectedImage: Image?
    @Binding var isShowingImagePicker: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                Button("Select Existing Image") {
                    
                }
                .padding()

                Button("Upload New Image") {
                    
                }
                .padding()
            }
            .navigationBarTitle("Options", displayMode: .inline)
            .navigationBarItems(trailing: Button("Done") {
                isShowingImagePicker = false
            })
        }
    }
}
