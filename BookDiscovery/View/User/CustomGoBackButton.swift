//
//  CustomGoBackButton.swift
//  BookDiscovery
//
//  Created by Thai, Le Hong on 14/09/2023.
//

import SwiftUI

struct CustomBackButton: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "arrowshape.backward.fill") // Use your desired system image
                    .font(.system(size: 20))
                    .foregroundColor(.orange)
                Text("Back")
                    .foregroundColor(.orange)
                    .font(.system(size: 20))
            }
        }
    }
}
