//
//  UserModel.swift
//  Book Lover
//
//  Created by Loc Phan Vinh on 11/09/2023.
//

// Import the Foundation framework
import Foundation
import SwiftUI
import Firebase
import UserNotifications

// Define UserViewModel class, which will be used to manage User data
class UserViewModel: ObservableObject {
    // Declare observable properties
    @Published var currentUser: User  // Holds the current User object
    @Published var isSignedIn: Bool = false  // Tracks if the user is signed in
    @Published var showSettings: Bool = false 
    @Published var searchText: String = ""
    @Published var userBGImage: UIImage = UIImage(named: "background") ?? UIImage(named: "")!
    @Published var userImage: UIImage = UIImage(named: "profile") ?? UIImage(named: "")!
    @Published var selectedTheme: String = "System"
    @Published var selectedFont: String = "San Francisco"
    @Published var selectedFontSize: CGFloat = 16.0
    @Published var searchHistory: [String] = []
    @Published var darkMode: Bool = false
    
    let themes = ["System", "Light", "Dark"]
    let fonts = ["San Francisco", "Helvetica", "Arial"]
    
    // Initializer
    init() {
        currentUser = emptyUser  // Initialize currentUser with default or provided user object
    }
    
    // Initialize User properties from a given dictionary
    func initUser(from dictionary: [String: Any]) {
        self.currentUser.id = dictionary["id"] as? String ?? ""
        self.currentUser.email = dictionary["email"] as? String ?? ""
        self.currentUser.name = dictionary["name"] as? String ?? ""
        
        // Parse 'address' sub-dictionary
        let address = dictionary["address"] as? [String : Any] ?? [:]
        self.currentUser.address.street = address["street"] as? String ?? ""
        self.currentUser.address.city = address["city"] as? String ?? ""
        self.currentUser.address.country = address["country"] as? String ?? ""
        
        // Initialize bio
        self.currentUser.bio = dictionary["bio"] as? String ?? ""
        
        // Set wishlist for books
        self.currentUser.wishlist = dictionary["wishlist"] as? [String] ?? []
        self.currentUser.searchHistory = dictionary["searchHistory"] as? [String] ?? []
    }
    
    // Convert User properties to dictionary format
    func toDictionary(user: User) -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary["id"] = user.id
        dictionary["email"] = user.email
        dictionary["name"] = user.name
        
        // Convert 'address' to sub-dictionary
        dictionary["address"] = [
            "street" : user.address.street,
            "city" : user.address.city,
            "country" : user.address.country
        ]
        
        // Include bio
        dictionary["bio"] = user.bio
        
        // Include wishlists
        dictionary["wishlist"] = user.wishlist
        dictionary["searchHistory"] = user.searchHistory
        return dictionary
    }
    
    // Function to validate email
    func validateEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
    
    
    // Fetch profile and background images
    func fetchUserImage() {
        ImageStorage().getProfile() { result in
            DispatchQueue.main.async {
                if let image = result {
                    self.userImage = image
                }
            }
        }

        ImageStorage().getBackground() { result in
            DispatchQueue.main.async {
                if let image = result {
                    self.userBGImage = image
                }
            }
        }
    }

    // Fetch user data from Firebase
    func fetchUserData() {
        if let userID = Auth.auth().currentUser?.uid {
            FireBaseDB().fetchUser(userID: userID) { fetchedUser in
                self.currentUser = fetchedUser ?? emptyUser
            }
        }
    }
    
}
