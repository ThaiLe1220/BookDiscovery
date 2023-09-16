//
//  CustomGoBackButton.swift
//  BookDiscovery
//
//  Created by Thai, Le Hong on 14/09/2023.
//

import SwiftUI

struct CustomBackButton: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var buttonColor : Color
    var text: String

    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack (spacing: 4) {
                Image(systemName: "arrowshape.backward.fill") // Use your desired system image
                    .font(.system(size: 15))
                    .foregroundColor(buttonColor)
                Text("\(text)")
                    .foregroundColor(buttonColor)
                    .font(.system(size: 18))
            }
        }
    }
}
