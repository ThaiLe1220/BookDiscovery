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
    func addUser(userID: String, userEmail: String, userName: String, completion: @escaping (Bool) -> Void) {
        // Create a new document in the "users" collection
        var newUser = emptyUser
        newUser.id = userID
        newUser.email = userEmail
        newUser.name = userName
        newUser.bio = "Hello, I am new here ;D"
        
        db.collection("users").addDocument(data: UserViewModel(user: newUser).toDictionary()) { error in
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
        // Fetch the image URL
        fetchBookImageURL(bookID: bookID) { imageURL in
            
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
                book.category = value?["category"] as? [String] ?? []
                book.headline = value?["headline"] as? String ?? ""
                book.description = value?["description"] as? String ?? ""
                book.rating = value?["rating"] as? Double ?? 0.0
                book.totalRated = value?["totalRated"] as? Int ?? 0
                let author = value?["author"] as? [String: Any] ?? [:]
                book.author.name = author["name"] as? String ?? ""
                book.imageURL = imageURL
                
                completion(book)
            })
        }
    }

    func getAllBooks(completion: @escaping (Book?) -> Void) {
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
            
            var newBook: Book = emptyBook
            
            let idToString = childData["id"] as? Int ?? 0

            newBook.id = String(idToString)
            newBook.name = childData["name"] as? String ?? ""
            newBook.category = childData["category"] as? [String] ?? []
            newBook.headline = childData["headline"] as? String ?? ""
            newBook.rating = childData["rating"] as? Double ?? 0.0
            newBook.totalRated = childData["totalRated"] as? Int ?? 0
            newBook.description = childData["description"] as? String ?? ""
            
            
            let author = childData["author"] as? [String: Any] ?? [:]
            newBook.author.name = author["name"] as? String ?? ""

            // Handle image URL
            if let imageURLString = childData["imageURL"] as? String, let imageURL = URL(string: imageURLString) {
                newBook.imageURL = imageURL
            } else {
                newBook.imageURL = nil
            }
            
            completion(newBook)
        })
        
    }
    
    
    func fetchBookImageURL(bookID: String, completion: @escaping (URL?) -> Void) {
    // Get a reference to the Firebase Realtime Database
       let databaseRef = Database.database().reference()

       // Construct the path to the book using the bookID
       let bookRef = databaseRef.child("books").child(bookID)

       // Retrieve the imageURL from the specified book
       bookRef.observeSingleEvent(of: .value) { snapshot in
           guard let bookData = snapshot.value as? [String: Any],
                 let imageURLString = bookData["imageURL"] as? String,
                 let imageURL = URL(string: imageURLString) else {
               completion(nil)
               return
           }

           completion(imageURL)
       }
    }
    
    // MARK: - Add Review
    func addReview(userID: String, bookID: String, rating: Double, comment: String, completion: @escaping (Review?) -> Void) {
        // Create a new document in the "users" collection
        var newReview = emptyReview
        var formattedDateForID: String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyyMMddhhmmss"
            return dateFormatter.string(from: Date())
        }
        var formattedDateTime: String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            return dateFormatter.string(from: Date())
        }
        newReview.id = "\(formattedDateForID)_\(userID)_\(bookID)"
        newReview.userID = userID
        newReview.bookID = bookID
        newReview.date = formattedDateTime
        newReview.rating = rating
        newReview.comment = comment
        
        db.collection("reviews").addDocument(data: ReviewViewModel(from: newReview).toDictionary()) { error in
            if error != nil {
                completion(nil)
            } else {
                completion(newReview)
            }
        }
    }

    // MARK: - get All Reviews
    func getAllReviews(bookID: String, completion: @escaping ([Review]?) -> Void) {
        db.collection("reviews").whereField("bookID", isEqualTo: bookID).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching reviews: \(error.localizedDescription)")
                completion(nil)
            } else {
                var result: [Review] = []
                for document in querySnapshot!.documents {
                    if let review = try? document.data(as: Review.self) {
                        result.append(review)
                    }
                }
                completion(result)
            }
        }
    }
}
