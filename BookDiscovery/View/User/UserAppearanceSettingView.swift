//
//  UserAppearanceSettingView.swift
//  BookDiscovery
//
//  Created by Thai, Le Hong on 15/09/2023.
//

import SwiftUI

struct UserAppearanceSettingView: View {
    @Binding var isOn: Bool
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
                        Toggle(isOn: $isOn) {
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
                        Slider(value: $userViewModel.selectedFontSize, in: 14...18, step: 1)
                            .frame(width: UIScreen.main.bounds.width/3)
                    }
                    .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize+1))
                }
  

                
                // Placeholder for future development ideas
                Section(header: Text("More Options").font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize-3))) {
//                    Button("Future Option 1") {
//                        // Placeholder for future implementation
//                    }
                }
            }
            .padding(.top, 45)
            .background(Color(UIColor.secondarySystemBackground))
            VStack {
                HStack {
                    CustomBackButton(userViewModel: userViewModel, buttonColor: Color( isOn ? UIColor.white : UIColor.black), text: "Settings")
                        .padding()
                    Spacer()
                }
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true) // Hide the default back button
        .environment(\.colorScheme, isOn ? .dark : .light)
    }
}

struct UserAppearanceSettingView_Previews: PreviewProvider {
    static var previews: some View {
        UserAppearanceSettingView(isOn: .constant(false), userViewModel: UserViewModel())
    }
}
