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

            NavigationLink(destination: UserSignUpView()) {
                Text("Don't have an account? Sign Up")
            }
        }
    }
    
    
//    // Function to handle user sign in
//    func UserSignIn() {
//        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
//            if let error = error {
//                print("Error signing in user: \(error.localizedDescription)")
//            } else {
//                print("User Signed In")
//
//            }
//        }
//    }
}

struct UserSignInView_Previews: PreviewProvider {
    static var previews: some View {
        UserSignInView()
    }
}
