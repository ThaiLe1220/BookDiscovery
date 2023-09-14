//
//  ContentView.swift
//  BookDiscovery
//
//  Created by Lê Ngọc Trâm on 11/09/2023.
//

import SwiftUI

// Define the ContentView, the main UI container for your application
struct ContentView: View {
    
    // StateObject to store and observe UserViewModel
    @StateObject var userViewModel = UserViewModel()

    // The main body of the ContentView
    var body: some View {
        // Using NavigationView as the root container
        NavigationView {
            
            // Conditional rendering based on whether the user is signed in or not
            if userViewModel.isSignedIn {
                // If signed in, present the UserProfileView
                UserProfileView(userViewModel: userViewModel)
            } else {
                // Otherwise, show the UserSignInView for authentication
                UserSignInView(userViewModel: userViewModel)
            }
        }
    }
}

// SwiftUI Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
