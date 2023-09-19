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
    @StateObject var bookViewModel = BookViewModel()
    @StateObject var reviewViewModel = ReviewViewModel()

    // The main body of the ContentView
    var body: some View {
        NavigationView {
            if userViewModel.isSignedIn {
                MainView(userViewModel: userViewModel, bookViewModel: bookViewModel, reviewViewModel: ReviewViewModel())
            }
            else {
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
