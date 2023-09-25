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

struct ResetPasswordView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @ObservedObject var userViewModel: UserViewModel // ViewModel for managing user data

    @State private var email: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var currentPassword: String = ""
    @State private var newPassword: String = ""
    @State private var isValidEmail: Bool = false
    @State private var buttonScale: CGFloat = 1.0

    var body: some View {
        ZStack {
            // Background image
            Image("wall-e")
                .resizable()
                .ignoresSafeArea()
                .opacity(0.85)
            
            GeometryReader { geometry in
                VStack (alignment: .center) {
                    Text("Change Password")
                            .font(.system(size: 32, weight: .semibold))
                            .padding(.vertical, 20)
                            .foregroundColor(.orange)
             
                        
                    VStack (spacing: 12) {
                        VStack (spacing: 4) {
                            HStack {
                                Text("Email")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.white) // Fallback color
                                    .overlay(
                                        LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]),
                                                       startPoint: .leading,
                                                       endPoint: .trailing)
                                    )
                                    .mask(
                                        Text("Email")
                                            .font(.system(size: 18, weight: .semibold))
                                    )

                                Spacer()
                            }
                            ZStack {
                                RoundedRectangle(cornerRadius: 7)
                                    .foregroundColor(Color(UIColor.tertiaryLabel))
                                    .frame(width: geometry.size.width * 0.8 + 18, height: 46)
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
                                
                                TextField("", text: $email)
                                    .autocapitalization(.none)  // Disable automatic capitalization
                                    .disableAutocorrection(true) // Disable autocorrection
                                    .padding(.horizontal)
                                    .foregroundColor(.white)

                            }
                            .font(.system(size: 18))
       
                            // Validation logic for email
                            .onChange(of: email) { _ in
                                isValidEmail = userViewModel.validateEmail(email)
                            }
                        }
                    }
                    .frame(width: geometry.size.width * 0.8)

                    Button(action: {
                        self.buttonScale = 0.8
                        withAnimation {
                            self.buttonScale = 1
                        }
 
                        // Invoke user reset-password logic
                        userResetPassword()
                    }) {
                        Text("Continue")
                            .scaleEffect(self.buttonScale)
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
                        Alert(title: Text("Password Reset"),
                              message: Text(alertMessage),
                              dismissButton: .default(Text("OK")))
                    }
                    .padding(.vertical, 20)
                }
                .frame(width: geometry.size.width, height: 750)
            }
            .offset(y: -UIScreen.main.bounds.height*0.08)
            
            HStack {
                CustomBackButton(userViewModel: userViewModel, buttonColor: Color(UIColor.orange), text: "Sign In")
                    .padding()
                Spacer()
            }
            .offset(y:-UIScreen.main.bounds.height*0.4)
        }
        .navigationBarBackButtonHidden(true)
    }
    
    // Function to validate the form input
    func isValidInput() -> Bool {
        if !isValidEmail {
            alertMessage = "Please enter a valid email address."
            return false
        }
        
        return true
    }
    
    // Function to handle user sign-up
    func userResetPassword() {
        if isValidInput() {
            // Firebase reset password logic
            FirebaseAuthService().resetPassword(email: email) { success, error in
                if success {
                    showAlert = true
                    alertMessage = "Password reset email has been sent. Please check your email."
                    
                    // Simulate delay and dismiss view
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                } else {
                    showAlert = true
                    alertMessage = "Failed to send password reset email: \(error?.localizedDescription ?? "Unknown error")"
                }
            }
        } else {
            self.showAlert = true
        }
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView(userViewModel: UserViewModel())
    }
}
