/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author/Group: 3 - Book Discovery
  Created  date: 15/09/2023
  Last modified: 25/09/2023
  Acknowledgement: N/A
*/

import SwiftUI

struct UserAppearanceSettingView: View {
    @ObservedObject var userViewModel: UserViewModel
    
    var mode = ["Dark", "Light"]
    var modeCase = [true, false]
    
    var body: some View {
        ZStack {
            Form {
                // Theme Picker
                Section(header: Text("Theme").font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize-3))) {
                    HStack {
                        Text("Dark Mode")
                            .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize+1))
                            .fontWeight(.regular)
                        Toggle(isOn: $userViewModel.isOn) {
                        }
                    }
                }
                
                // Font Picker
                Section(header: Text("Font").font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize-3))) {
                    Picker("Select Font", selection: $userViewModel.selectedFont) {
                        ForEach(userViewModel.fonts, id: \.self) {
                            Text($0)
                                .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                        }
                    }
                    .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize+1))
                    
                    HStack (spacing: 8) {
                        Text("Font Size: \(String(format: "%.1f", userViewModel.selectedFontSize))")
                            .lineLimit(1)
                        Spacer()
                        Slider(value: $userViewModel.selectedFontSize, in: 14...20, step: 1)
                            .frame(width: UIScreen.main.bounds.width/3)
                    }
                    .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize+1))
                }
  

                
//                // Placeholder for future development ideas
//                Section(header: Text("More Options").font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize-3))) {
////                    Button("Future Option 1") {
////                        // Placeholder for future implementation
////                    }
//                }
            }
            .padding(.top, 45)
            .background(Color(UIColor.secondarySystemBackground))
            VStack {
                HStack {
                    CustomBackButton(userViewModel: userViewModel, buttonColor: Color( userViewModel.isOn ? UIColor.white : UIColor.black), text: "Settings")
                        .padding()
                    Spacer()
                }
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true) // Hide the default back button
        .environment(\.colorScheme, userViewModel.isOn ? .dark : .light)
    }
}

struct UserAppearanceSettingView_Previews: PreviewProvider {
    static var previews: some View {
        UserAppearanceSettingView(userViewModel: UserViewModel())
    }
}
