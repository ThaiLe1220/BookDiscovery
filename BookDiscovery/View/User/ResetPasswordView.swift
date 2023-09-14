//
//  ResetPasswordView.swift
//  BookDiscovery
//
//  Created by Huy Hua Nam on 14/09/2023.
//

import SwiftUI

struct ResetPasswordView: View {
    @State private var email: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var currentPassword: String = ""
    @State private var newPassword: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("Forgot\nPassword?")
                    .bold()
                    .font(.largeTitle)
                .multilineTextAlignment(.leading)
                Spacer()
            }.padding()
                
        
            TextField("Email", text: $email)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
            Button("RESET PASSWORD") {
                FirebaseAuthService().resetPassword(email: email) { success, error in
                    if success {
                        showAlert = true
                        alertMessage = "Password reset email has been sent. Please check your email."
                    } else {
                        showAlert = true
                        alertMessage = "Failed to send password reset email: \(error?.localizedDescription ?? "Unknown error")"
                    }
                }
            }
            .bold()
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Password Reset"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
