/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author/Group: 3 - Book Discovery
  Created  date: 25/09/2023
  Last modified: 25/09/2023
  Acknowledgement: N/A
*/

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
    var searchHistory: [String]
}

// Initialize with default empty values
let emptyUser = User(
    id: "",
    email: "",
    name: "",
    address: Address(street: "", city: "", country: ""),
    bio: "",
    wishlist: [],
    searchHistory: []
)

// A sample user for testing purposes
let testUser = User(
    id: "-1",
    email: "thai@gmail.com",
    name: "eugene",
    address: Address(street: "nguyen huu canh", city: "ho chi minh city", country: "viet nam"),
    bio: "I love books in general",
    wishlist: ["-1", "-2"],
    searchHistory: ["hjhj", "1231"]
)

let testUser2 = User(
    id: "-2",
    email: "lehongthai@hihicute.com",
    name: "eugenememe",
    address: Address(street: "10XT Rennie Street", city: "London", country: "UK"),
    bio: "I love books in general, but dont like reading book xD",
    wishlist: ["-1"],
    searchHistory: ["LOL", "chao anh Bao :))"]
)


