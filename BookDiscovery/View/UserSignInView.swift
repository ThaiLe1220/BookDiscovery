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
            }
            .padding()

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
