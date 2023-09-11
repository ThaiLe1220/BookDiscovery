//
//  UserProfileView.swift
//  BookDiscovery
//
//  Created by Huy Hua Nam on 11/09/2023.
//

import SwiftUI
import Firebase

struct UserProfileView: View {
    @State private var isSignedOut = false
    
    var body: some View {
        Button("Sign Out") {
            // Handle sign out
            signOut()
        }
        .padding()
    }
    
    // function to handle user sign out
    func signOut() {
        do {
            try Auth.auth().signOut()
            isSignedOut = true
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError.localizedDescription)")
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
