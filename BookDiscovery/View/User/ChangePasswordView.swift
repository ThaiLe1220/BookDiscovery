//
//  ChangePasswordView.swift
//  BookDiscovery
//
//  Created by Huy Hua Nam on 14/09/2023.
//

import SwiftUI


struct ChangePasswordView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State private var currentPassword: String = ""
    @State private var newPassword: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var changeButtonScale: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                VStack (alignment: .center) {
                    Spacer()
                    Text("Change Password")
                        .font(.system(size: 32, weight: .semibold))
                        .padding(.vertical, 20)
                        .foregroundColor(.orange)
                    
                    VStack (spacing: 12) {
                        // Current Password input section.
                        VStack (spacing: 4) {
                            HStack {
                                Text("Current Password")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.orange)
                                Spacer()
                            }
                            ZStack {
                                RoundedRectangle(cornerRadius: 7)
                                    .foregroundColor(Color(UIColor.tertiaryLabel))
                                    .frame(height: 46)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 7)
                                            .stroke(Color.clear, lineWidth: 1)
                                            .overlay(
                                                LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]),
                                                               startPoint: .leading,
                                                               endPoint: .trailing)
                                            )
                                            .mask(
                                                RoundedRectangle(cornerRadius: 7)
                                                    .stroke(lineWidth: 1)
                                            )
                                    )

                                SecureField("", text: $currentPassword)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .padding(.horizontal)
                                    .foregroundColor(.white)
                            }
                            .font(.system(size: 18))
                        }
                        
                        // New Password input section.
                        VStack (spacing: 4) {
                            HStack {
                                Text("New Password")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.orange)
                                Spacer()
                            }
                            ZStack {
                                RoundedRectangle(cornerRadius: 7)
                                    .foregroundColor(Color(UIColor.tertiaryLabel))
                                    .frame(height: 46)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 7)
                                            .stroke(Color.clear, lineWidth: 1)
                                            .overlay(
                                                LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]),
                                                               startPoint: .leading,
                                                               endPoint: .trailing)
                                            )
                                            .mask(
                                                RoundedRectangle(cornerRadius: 7)
                                                    .stroke(lineWidth: 1)
                                            )
                                    )

                                SecureField("", text: $newPassword)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .padding(.horizontal)
                                    .foregroundColor(.white)
                            }
                            .font(.system(size: 18))
                        
                    }       }
                        .frame(width: geometry.size.width * 0.8)

                    ZStack {
                        Button(action: {
                            self.changeButtonScale = 0.8
                            withAnimation {
                                self.changeButtonScale = 1
                            }
                            
                            UserChangePassword()
                        }) {
                            Text("Continue")
                                .scaleEffect(self.changeButtonScale)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.vertical, 12)
                                .padding(.horizontal, 40)
                        }
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.orange, Color.red]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .cornerRadius(25)
                        .font(.system(size: 20, weight: .semibold))
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("Change Password"),
                                  message: Text(alertMessage),
                                  dismissButton: .default(Text("OK")))
                        }
                    .padding(.vertical, 20)
                    }
                    
                    Spacer()

                }
                .frame(width: geometry.size.width, height: 750)
            }
            .offset(y: -UIScreen.main.bounds.height*0.08)
            
            HStack {
                CustomBackButton()
                    .padding()
                Spacer()
            }
            .offset(y:-UIScreen.main.bounds.height*0.44)
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func UserChangePassword(){
        FirebaseAuthService().changePassword(currentPassword: currentPassword, newPassword: newPassword) { success, error in
            if success {
                showAlert = true
                alertMessage = "Password changed successfully."
                // Simulate delay and dismiss view
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.presentationMode.wrappedValue.dismiss()
                }
            } else {
                showAlert = true
                alertMessage = "Failed to change password: \(error?.localizedDescription ?? "Unknown error")"
            }
        }
    }
}


struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
