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
    @State private var signInSuccess = false

    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            SecureField("Password", text: $password)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button("Sign In") {
                signIn()
            }
            .padding()

            NavigationLink(destination: UserSignUpView()) {
                Text("Don't have an account? Sign Up")
            }
        }
    }
    
    // Function to handle user sign in
    func signIn() {
        Auth.auth().signIn(withEmail: email, password: password) { (result,error) in
            if let error = error {
                print("Error signing in user: \(error.localizedDescription)")
            } else {
                print("User Signed In")
                signInSuccess = true
            }
        }
    }
}

struct UserSignInView_Previews: PreviewProvider {
    static var previews: some View {
        UserSignInView()
    }
}
