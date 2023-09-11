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
        }
        .padding()
    }

}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
