//
//  UserModel.swift
//  Book Lover
//
//  Created by Loc Phan Vinh on 11/09/2023.
//

// Import the Foundation framework
import Foundation

// Define UserViewModel class, which will be used to manage User data
class UserViewModel: ObservableObject {
    // Declare observable properties
    @Published var currentUser: User  // Holds the current User object
    @Published var isSignedIn: Bool = false  // Tracks if the user is signed in
    
    // Initializer
    init(user: User = User.emptyUser) {
        currentUser = user  // Initialize currentUser with default or provided user object
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
    }
    
    // Convert User properties to dictionary format
    func toDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary["id"] = self.currentUser.id
        dictionary["email"] = self.currentUser.email
        dictionary["name"] = self.currentUser.name
        
        // Convert 'address' to sub-dictionary
        dictionary["address"] = [
            "street" : self.currentUser.address.street,
            "city" : self.currentUser.address.city,
            "country" : self.currentUser.address.country
        ]
        
        // Include bio
        dictionary["bio"] = self.currentUser.bio
        
        return dictionary
    }
}
