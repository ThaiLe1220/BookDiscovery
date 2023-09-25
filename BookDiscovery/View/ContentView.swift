/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author/Group: 3 - Book Discovery
  Created  date: 11/09/2023
  Last modified: 25/09/2023
  Acknowledgement: N/A
*/

import SwiftUI
import Firebase

// Define the ContentView, the main UI container for your application
struct ContentView: View {
    // StateObject to store and observe UserViewModel
    @StateObject var userViewModel = UserViewModel()
    @StateObject var bookViewModel = BookViewModel()
    @StateObject var reviewViewModel = ReviewViewModel()

    @State private var isActive:Bool = false

    // The main body of the ContentView
    var body: some View {
        NavigationView {
            if (isActive) {
                if userViewModel.isSignedIn {
                    MainView(userViewModel: userViewModel, bookViewModel: bookViewModel, reviewViewModel: reviewViewModel)
                }
                else {
                    UserSignInView(userViewModel: userViewModel)
                }
            }
            else {
                SplashScreenView(isActive: $isActive)
            }
        }
        .environment(\.colorScheme, userViewModel.isOn ? .dark : .light)
    }
}

// SwiftUI Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
