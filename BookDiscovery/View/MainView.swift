//
//  MainView.swift
//  BookDiscovery
//
//  Created by Thai, Le Hong on 15/09/2023.
//

import SwiftUI
import Firebase
import UserNotifications

struct MainView: View {
    
    @Binding var isOn:Bool
    // StateObject to store and observe UserViewModel
    @ObservedObject var userViewModel: UserViewModel
    @ObservedObject var bookViewModel: BookViewModel
    @ObservedObject var reviewViewModel: ReviewViewModel

    @State private var selectedTab = 0
    @State private var searchText: String = ""
    
    var body: some View {
        VStack {
            TabView (selection: $selectedTab){
                /// Browse View
                HomeView(isOn: $isOn, userViewModel: userViewModel, bookViewModel: bookViewModel, reviewViewModel: reviewViewModel)
                    .tabItem {Label("Home", systemImage: "house")}
                    .tag(0)
                    .onAppear {
                        userViewModel.showSettings = false
                    }
    
                /// Browse View
                BrowseView(isOn: $isOn, userViewModel: userViewModel, bookViewModel: bookViewModel, reviewViewModel: reviewViewModel)
                    .tabItem {Label("Browse", systemImage: "square.grid.2x2")}
                    .tag(1)
                    .onAppear {
                        userViewModel.showSettings = false
                    }
    
                /// Search View
                SearchView(isOn: $isOn, userViewModel: userViewModel)
                    .tabItem {Label("Search", systemImage: "magnifyingglass")}
                    .tag(2)
                    .onAppear {
                        userViewModel.showSettings = false
                    }
    
                /// My Books
                WishlistView(isOn: $isOn, userViewModel: userViewModel, bookViewModel: bookViewModel, reviewViewModel: reviewViewModel)
                    .tabItem {Label("My Books", systemImage: "heart.circle")}
                    .tag(3)
                    .onAppear {
                        userViewModel.showSettings = false
                    }
    
                /// Notifications
                NotificationsView(isOn: $isOn, userViewModel: userViewModel)
                    .tabItem {Label("Notifications", systemImage: "bell")}
                    .tag(4)
                    .onAppear {
                        userViewModel.showSettings = false
                    }
            }
            .accentColor(Color("OrangeMain")) // Change the color of the selected tab item
        }
        .background(Color(UIColor.secondarySystemBackground))
        .onAppear {
            // Fetch current user data and images when view appears
            userViewModel.fetchUserData()
            userViewModel.fetchUserImage()
            print(userViewModel.currentUser)
        }
    }
    
    
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(isOn: .constant(false), userViewModel: UserViewModel(), bookViewModel: BookViewModel(), reviewViewModel: ReviewViewModel())
    }
}
