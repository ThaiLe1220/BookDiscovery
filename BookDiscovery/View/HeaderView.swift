/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author/Group: 3 - Book Discovery
  Created  date: 22/09/2023
  Last modified: 25/09/2023
  Acknowledgement: N/A
*/

import SwiftUI

struct HeaderView: View {
    @ObservedObject var userViewModel : UserViewModel
    
    @State private var showProfile = false

    var tabName: String
    
    var body: some View {
        HStack {
            Text("\(tabName)")
                .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize+12))
                .fontWeight(.bold)
                .foregroundColor(userViewModel.isOn ? .white : .black)
            Spacer()
            Button(action: {
                showProfile.toggle()
            }) {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color("OrangeMain"))
            }
            .sheet(isPresented: $showProfile) {
                SettingView(userViewModel: userViewModel)
            }
        }
        .padding(.horizontal)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(userViewModel: UserViewModel(), tabName: "Tab Name")
    }
}
