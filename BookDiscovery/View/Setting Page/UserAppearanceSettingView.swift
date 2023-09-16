//
//  UserAppearanceSettingView.swift
//  BookDiscovery
//
//  Created by Thai, Le Hong on 15/09/2023.
//

import SwiftUI

struct UserAppearanceSettingView: View {
    @ObservedObject var userViewModel: UserViewModel
    
    var body: some View {
        ZStack {
            Form {
                // Theme Picker
                Section(header: Text("Theme")) {
                    Picker("Select Theme", selection: $userViewModel.selectedTheme) {
                        ForEach(userViewModel.themes, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                // Font Picker
                Section(header: Text("Font")) {
                    Picker("Select Font", selection: $userViewModel.selectedFont) {
                        ForEach(userViewModel.fonts, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    HStack (spacing: 8) {
                        Text("Font Size: \(String(format: "%.1f", userViewModel.selectedFontSize))")
                            .lineLimit(1)
                        Spacer()
                        Slider(value: $userViewModel.selectedFontSize, in: 14...18, step: 0.5)
                            .frame(width: UIScreen.main.bounds.width/3)
                    }
                    .font(.system(size:userViewModel.selectedFontSize))
                }
  

                
                // Placeholder for future development ideas
                Section(header: Text("More Options")) {
//                    Button("Future Option 1") {
//                        // Placeholder for future implementation
//                    }
                }
            }
            .padding(.top, 45)
            .background(Color(UIColor.secondarySystemBackground))

            HStack {
                CustomBackButton(buttonColor: Color(UIColor.black), text: "Settings")
                    .padding()
                Spacer()
            }
            .offset(y:-UIScreen.main.bounds.height*0.42)
        }
        .navigationBarBackButtonHidden(true) // Hide the default back button
    }
}

struct UserAppearanceSettingView_Previews: PreviewProvider {
    static var previews: some View {
        UserAppearanceSettingView(userViewModel: UserViewModel())
    }
}
