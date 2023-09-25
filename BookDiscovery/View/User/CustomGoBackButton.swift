/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author/Group: 3 - Book Discovery
  Created  date: 14/09/2023
  Last modified: 25/09/2023
  Acknowledgement: N/A
*/

import SwiftUI

struct CustomBackButton: View {
    // MARK: - Variables
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var userViewModel: UserViewModel

    var buttonColor : Color
    var text: String

    // MARK: - Main View
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
                    .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize+2))
            }
        }
    }
}
