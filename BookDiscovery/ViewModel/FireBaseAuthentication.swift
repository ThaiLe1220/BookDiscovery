//
//  FireBaseAuthentication.swift
//  BookDiscovery
//
//  Created by Huy Hua Nam on 11/09/2023.
//

import Foundation
import Firebase

var currentUser: User? {
    UserModel().currentUser
}
var email: String {
    currentUser?.email ?? ""
}
var password: String {
    currentUser?.password ?? ""
}

// Function to handle user sign up
func signUp() -> Bool {
    var result = false
    Auth.auth().createUser(withEmail: email, password: password) {authResult, error in
        if let error = error {
            print("Error creating user: \(error.localizedDescription)")
        } else {
            print("User created successfully")
            result = true
        }
    }
    return result
}

// Function to handle user sign in
func signIn() -> Bool {
    var result = false
    Auth.auth().signIn(withEmail: email, password: password) { (authResult,error) in
        if let error = error {
            print("Error signing in user: \(error.localizedDescription)")
        } else {
            print("User Signed In")
            result = true
        }
    }
    return result
}

func signOut() -> Bool {
    var result = false
    do {
        try Auth.auth().signOut()
        result = true
    } catch let signOutError as NSError {
        print("Error signing out: \(signOutError.localizedDescription)")
    }
    return result
}
