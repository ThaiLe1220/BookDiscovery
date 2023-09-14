//
//  FireBaseDB.swift
//  Book Lover
//
//  Created by Loc Phan Vinh on 11/09/2023.
//

// Import the necessary libraries for Firebase and Firestore functionalities
import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseDatabase


// Initialize Firestore database instance
let db = Firestore.firestore()


// Define the FireBaseDB class
class FireBaseDB {
    // MARK: - Add User
    // Function to add a new user to the Firestore "users" collection
    func addUser(userID: String, userEmail: String, completion: @escaping (Bool) -> Void) {
        // Create a new document in the "users" collection
        db.collection("users").addDocument(data: ["id" : userID, "email" : userEmail]) { error in
            if error != nil {
                // Return failure if an error occurs
                completion(false)
            } else {
                // Otherwise, return success
                completion(true)
            }
        }
    }

    // MARK: - Read
    // Function to fetch a user based on userID from Firestore
    func fetchUser(userID: String, completion: @escaping (User?) -> Void) {
        // Query Firestore to find documents where "id" field matches the userID
        db.collection("users")
            .whereField("id", isEqualTo: userID)
            .getDocuments { querySnapshot, error in
                if error != nil {
                    // Return nil if an error occurs
                    completion(nil)
                } else {
                    // Parse the fetched user data into a User object
                    if let document = querySnapshot?.documents.first,
                       let user = try? document.data(as: User.self) {
                        // Return the User object
                        completion(user)
                    } else {
                        // Return nil if no user is found
                        completion(nil)
                    }
                }
            }
    }

    // MARK: - Update
    // Function to update existing user data
    func updateUser(user: User, completion: @escaping (Bool) -> Void) {
        // Get email from user object
        let userEmail = user.email

        // Convert User object to a dictionary
        let userData = UserViewModel(user: user).toDictionary()
        
        // Search for the user by email
        db.collection("users").whereField("email", isEqualTo: userEmail).getDocuments { (querySnapshot, error) in
            if error != nil{
                // Return failure if an error occurs
                completion(false)
            } else {
                // Update the found document with new data
                if let document = querySnapshot?.documents.first {
                    let userID = document.documentID
                    db.collection("users").document(userID).setData(userData) { error in
                        if error != nil {
                            // Return failure if an error occurs
                            completion(false)
                        } else {
                            // Otherwise, return success
                            completion(true)
                        }
                    }
                } else {
                    // Print message and return false if no user is found
                    print("User with email \(userEmail) not found.")
                    completion(false)
                }
            }
        }
    }

    // MARK: - Delete
    // Function to delete a user based on userID
    func deleteUser(userID: String, completion: @escaping (Bool) -> Void) {
        // Delete the document with the corresponding userID
        db.collection("users").document(userID).delete { error in
            if error != nil {
                // Return failure if an error occurs
                completion(false)
            } else {
                // Otherwise, return success
                completion(true)
            }
        }
    }

    // MARK: - Book ####################
    func getBook(bookID: String, completion: @escaping (Book?) -> Void) {
        // Get a reference to the Firebase Realtime Database
        let databaseRef = Database.database().reference()

        // Construct the path to the book using the bookID
        let bookRef = databaseRef.child("books") //.child(bookID)

        // Retrieve the data at the specified path
        bookRef.observeSingleEvent(of: .value, with: { snapshot in
            let value = snapshot.value as? [String: Any]
            var book: Book = emptyBook
            book.id = bookID
            book.name = value?["name"] as? String ?? ""
            book.category = value?["category"] as? String ?? ""
            book.headline = value?["headline"] as? String ?? ""
            book.description = value?["description"] as? String ?? ""
            book.price = value?["price"] as? Double ?? 0.0
            book.rating = value?["rating"] as? Double ?? 0.0
            let author = value?["author"] as? [String: Any] ?? [:]
            book.author.name = author["name"] as? String ?? ""
            
            completion(book)
        })
    }

    func getAllBooks(completion: @escaping ([String: Any]?) -> Void) {
        // Get a reference to the Firebase Realtime Database
        let databaseRef = Database.database().reference()

        // Construct the path to the book using the bookID
        let booksRef = databaseRef.child("books")

        // Retrieve the data at the specified path
        booksRef.observe(.childAdded, with: { (snapshot) in
            guard let childData = snapshot.value as? [String: Any] else {
                print("No data found for child node: \(snapshot.key)")
                return
            }
            completion([snapshot.key: childData])
        })
    }
}
