//
//  User.swift
//  Book Lover
//
//  Created by Loc Phan Vinh on 11/09/2023.
//

// Importing the Foundation library for basic Swift types and functions
// Importing FirebaseFirestoreSwift for Firebase integration
import Foundation
import FirebaseFirestoreSwift

// User struct that conforms to the Codable and Identifiable protocols
struct User: Codable, Identifiable {
    // Properties
    var id: String? // Optional ID, to be set by Firebase most likely
    var email: String // User's email address
    var name: String  // User's name
    var address: Address // Struct containing address details
    var bio: String  // User's bio or description
    var wishlist: [String] // Books that are wishlisted by user

}
// Initialize with default empty values
let emptyUser = User(
    id: "",
    email: "",
    name: "",
    address: Address(street: "", city: "", country: ""),
    bio: "",
    wishlist: []

)

// A sample user for testing purposes
let testUser = User(
    id: "-1",
    email: "thai@gmail.com",
    name: "eugene",
    address: Address(street: "nguyen huu canh", city: "ho chi minh city", country: "viet nam"),
    bio: "I love books in general",
    wishlist: ["0", "1"]
)
