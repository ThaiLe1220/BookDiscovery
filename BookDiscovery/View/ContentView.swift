//
//  ContentView.swift
//  BookDiscovery
//
//  Created by Lê Ngọc Trâm on 11/09/2023.
//

import SwiftUI
import Firebase

// Define the ContentView, the main UI container for your application
struct ContentView: View {
    // StateObject to store and observe UserViewModel
    @StateObject var userViewModel = UserViewModel()
    @StateObject var bookViewModel = BookViewModel()

    @State private var isOn: Bool = false

    // The main body of the ContentView
    var body: some View {
//        NavigationView {
//            if userViewModel.isSignedIn {
//                MainView(isOn: $isOn, userViewModel: userViewModel, bookViewModel: bookViewModel, reviewViewModel: ReviewViewModel())
//            }
//            else {
//                UserSignInView(isOn: $isOn, userViewModel: userViewModel)
//            }
//        }.environment(\.colorScheme, isOn ? .dark : .light)
        
        Button {
            
            FireBaseDB().deleteReview(reviewID: "20230919084845_uhofmYGj9WOuDQbfNKnGTk8eOsy1_0") { result in
                if result! {
                    print("Success")
                } else {
                    print("Fail")
                }

            }
        } label: {
            Text("Delete Review")
        }
    }
}

// SwiftUI Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
