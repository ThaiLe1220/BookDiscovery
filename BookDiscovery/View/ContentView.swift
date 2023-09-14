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

    @State private var selectedTab = 0
    @State private var searchText: String = ""
    
    // The main body of the ContentView
    var body: some View {
        if userViewModel.isSignedIn {
            NavigationView {
                TabView (selection: $selectedTab){
                    /// Browse View
                    HomeView(userViewModel: userViewModel)
                        .tabItem {Label("Home", systemImage: "house")}
                        .tag(0)
                        .onAppear {
                            userViewModel.showSettings = false
                        }
                    
                    /// Browse View
                    BrowseView(userViewModel: userViewModel)
                        .tabItem {Label("Browse", systemImage: "square.grid.2x2")}
                        .tag(1)
                        .onAppear {
                            userViewModel.showSettings = false
                        }
                    
                    /// Search View
                    SearchView(userViewModel: userViewModel)
                        .tabItem {Label("Search", systemImage: "magnifyingglass")}
                        .tag(2)
                        .onAppear {
                            userViewModel.showSettings = false
                        }
                    
                    /// My Books
                    WishlistView(userViewModel: userViewModel)
                        .tabItem {Label("My Books", systemImage: "heart.circle")}
                        .tag(3)
                        .onAppear {
                            userViewModel.showSettings = false
                        }
                    
                    /// Notifications
                    NotificationsView(userViewModel: userViewModel)
                        .tabItem {Label("Notifications", systemImage: "bell")}
                        .tag(4)
                        .onAppear {
                            userViewModel.showSettings = false
                        }
                }
            }
        } else {
            UserSignInView(userViewModel: userViewModel)
        }

    }
}

// SwiftUI Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


// Using NavigationView as the root container
//        NavigationView {
    
//            // Conditional rendering based on whether the user is signed in or not
//            if userViewModel.isSignedIn {
//                // If signed in, present the UserProfileView
//                UserProfileView(userViewModel: userViewModel)
//            } else {
//                // Otherwise, show the UserSignInView for authentication
//                UserSignInView(userViewModel: userViewModel)
//            }
//            UserSettingsView(userViewModel: userViewModel)
//        }
