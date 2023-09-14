//
//  ChangePasswordView.swift
//  BookDiscovery
//
//  Created by Huy Hua Nam on 14/09/2023.
//

import SwiftUI


struct ChangePasswordView: View {
    @State private var currentPassword: String = ""
    @State private var newPassword: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""

    var body: some View {
        VStack {
            SecureField("Current Password", text: $currentPassword)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .disableAutocorrection(true)

            SecureField("New Password", text: $newPassword)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .disableAutocorrection(true)

            Button("Change Password") {
                FirebaseAuthService().changePassword(
                    currentPassword: currentPassword,
                    newPassword: newPassword
                ) { success, error in
                    if success {
                        showAlert = true
                        alertMessage = "Password changed successfully."
                    } else {
                        showAlert = true
                        alertMessage = "Failed to change password: \(error?.localizedDescription ?? "Unknown error")"
                    }
                }
            }
            .padding()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Change Password"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}


struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
