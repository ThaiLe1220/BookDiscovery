//
//  UserSignInView.swift
//  BookDiscovery
//
//  Created by Huy Hua Nam on 11/09/2023.
//

import SwiftUI
import Firebase

struct UserSignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
   

    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)  // Disable automatic capitalization
                .disableAutocorrection(true) // Disable autocorrection
            
            SecureField("Password", text: $password)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)  // Disable automatic capitalization
                .disableAutocorrection(true) // Disable autocorrection

            HStack {
                Button("Sign In") {
                    FirebaseAuthService().signIn(email: email, password: password) { (success, error) in
                        if success {
                            print("User signed in successfully")
                        } else {
                            print("Failed to sign in")
                        }
                    }
                }
                .padding()
                
                // Button to test biometric authentication feature
                // Test on simulator. Use Features -> FaceID -> Matching Face
                Button {
                    FirebaseAuthService().biometricAuthentication()
                    print("Face ID button tapped")
                } label: {
                    HStack {
                        Image(systemName: "faceid")  // Face ID icon
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                    .padding()
                    .foregroundColor(.gray)
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                            .frame(width: 38, height: 38)
                    )
                }
            }
            NavigationLink(destination: UserSignUpView()) {
                Text("Don't have an account? Sign Up")
            }
        }
    }
    
}

struct UserSignInView_Previews: PreviewProvider {
    static var previews: some View {
        UserSignInView()
    }
}
