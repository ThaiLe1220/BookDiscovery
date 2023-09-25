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

struct ToastView: View {
    let message: String
    
    var body: some View {
        VStack {
            Text(message)
                .foregroundColor(.white)
                .padding(.vertical, 8)
                .background(Color.black.opacity(0.8))
                .cornerRadius(12)
                .padding(.horizontal, 20)
        }
        .transition(.move(edge: .top))
//        .animation(.easeInOut)
    }
}
