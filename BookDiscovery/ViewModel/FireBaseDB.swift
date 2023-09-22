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
        
        db.collection("users").addDocument(data: UserViewModel().toDictionary(user: newUser)) { error in
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
    func updateUser(user: User, completion: @escaping (Bool, Error?) -> Void) {
        // Get email from user object
        let userEmail = user.email

        // Convert User object to a dictionary
        let userData = UserViewModel().toDictionary(user: user)
        
        // Search for the user by email
        db.collection("users").whereField("email", isEqualTo: userEmail).getDocuments { (querySnapshot, error) in
            if error != nil{
                // Return failure if an error occurs
                completion(false, error)
            } else {
                // Update the found document with new data
                if let document = querySnapshot?.documents.first {
                    let userID = document.documentID
                    db.collection("users").document(userID).setData(userData) { error in
                        if error != nil {
                            // Return failure if an error occurs
                            completion(false, error)
                        } else {
                            // Otherwise, return success
                            completion(true, nil)
                        }
                    }
                } else {
                    // Print message and return false if no user is found
                    print("User with email \(userEmail) not found.")
                    completion(false, error)
                }
            }
        }
    }

    // MARK: - Delete User
    // Function to delete a user based on userID
    func deleteUser(completion: @escaping (Bool) -> Void) {
        // Delete the document with the corresponding userID
        
        let userID = Auth.auth().currentUser?.uid
        
        // Delete Authetication
        Auth.auth().currentUser?.delete() { error in
            if error != nil {
                completion(true)
            } else {
                completion(false)
                return
            }
        }
        
        // Delete in user collection
        db.collection("users").whereField("id", isEqualTo: userID ?? "").getDocuments { querySnapshot, error in
            if error != nil {
                // Return nil if an error occurs
                completion(false)
            } else {
                // Parse the fetched user data into a User object
                if let document = querySnapshot?.documents.first {
                   let documentID = document.documentID
                    
                    db.collection("users").document(documentID).delete { error in
                        if error != nil {
                            // Return failure if an error occurs
                            completion(false)
                        } else {
                            // Otherwise, return success
                            completion(true)
                        }
                    }
                } else {
                    completion(false)
                }
            }
        }
        
        // Delete in review collection
        db.collection("reviews").whereField("userID", isEqualTo: userID ?? "").getDocuments { querySnapshot, error in
            if error != nil {
                // Return nil if an error occurs
                completion(false)
            } else {
                // Parse the fetched user data into a User object
                if let document = querySnapshot?.documents.first {
                   let documentID = document.documentID
                    
                    db.collection("reviews").document(documentID).delete { error in
                        if error != nil {
                            // Return failure if an error occurs
                            completion(false)
                        } else {
                            // Otherwise, return success
                            completion(true)
                        }
                    }
                } else {
                    completion(false)
                }
            }
        }
        
        // Delete user image
        ImageStorage().deleteImagesFrom(userID: userID!) { success in
            if success! {
                completion(true)
            } else {
                completion(false)
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
                let author = value?["author"] as? [String: Any] ?? [:]
                
                let book: Book = Book(
                    id: bookID,
                    name: value?["name"] as? String ?? "",
                    category: value?["category"] as? [String] ?? [],
                    headline: value?["headline"] as? String ?? "",
                    rating: value?["rating"] as? Double ?? 0.0,
                    description: value?["description"] as? String ?? "",
                    imageURL: value?["imageURL"] as? String ?? "",
                    author: Author(name: author["name"] as? String ?? "")
                )

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
                
                let idToString = childData["id"] as? Int ?? 0
                let author = childData["author"] as? [String: Any] ?? [:]
                
                let book: Book = Book(
                    id: String(idToString),
                    name: childData["name"] as? String ?? "",
                    category: childData["category"] as? [String] ?? [],
                    headline: childData["headline"] as? String ?? "",
                    rating: childData["rating"] as? Double ?? 0.0,
                    description: childData["description"] as? String ?? "",
                    imageURL: childData["imageURL"] as? String ?? "",
                    author: Author(name: author["name"] as? String ?? "")
                )

                completion(book)
            })
            
        }
    
    func searchBooks(query: String, completion: @escaping ([Book]?) -> Void) {
        // Get a reference to the Firebase Realtime Database
        let databaseRef = Database.database().reference()
        
        // Convert the query to lowercase for case-insensitive search
        let lowercaseQuery = query.lowercased()
        
        var result: [Book] = []
        
        // Construct a query to search for books by name
        let booksRef = databaseRef.child("books")

        booksRef.observeSingleEvent(of: .value) { snapshot in
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                   let bookData = childSnapshot.value as? [String: Any] {
                    var book = emptyBook
                    book.id = childSnapshot.key
                    if let bookName = bookData["name"] as? String {
                        // Convert the book name to lowercase for comparison
                        let lowercaseBookName = bookName.lowercased()
                        
                        // Check if the lowercase book name contains the lowercase query
                        if lowercaseBookName.contains(lowercaseQuery) {
                            book.name = bookName
                            // Add other book attributes as needed

                            result.append(book)
                        }
                    }
                }
            }
            completion(result)
        }
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
    
    func fetchUserNameBy(userID: String, completion: @escaping (String?) -> Void) {
        // Query Firestore to find documents where "id" field matches the userID
        db.collection("users").whereField("id", isEqualTo: userID).getDocuments { querySnapshot, error in
            if error != nil {
                // Return nil if an error occurs
                completion(nil)
            } else {
                
                // Parse the fetched user data into a User object
                if let document = querySnapshot?.documents.first {
                    let username = document["name"] as? String ?? ""
                    completion(username)
                } else {
                    completion(nil)
                }
            }
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
            dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
            return dateFormatter.string(from: Date())
        }
        newReview.id = "\(formattedDateForID)_\(userID)_\(bookID)"
        newReview.userID = userID
        newReview.bookID = bookID
        newReview.date = formattedDateTime
        newReview.rating = rating
        newReview.comment = comment
        
        var dictionary: [String: Any] = [:]
        
        dictionary["id"] = newReview.id
        dictionary["userID"] = newReview.userID
        dictionary["bookID"] = newReview.bookID
        dictionary["date"] = newReview.date
        dictionary["rating"] = newReview.rating
        dictionary["comment"] = newReview.comment
        dictionary["likes"] = newReview.likes
        dictionary["votedUserIds"] = newReview.votedUserIds
                
        db.collection("reviews").addDocument(data: dictionary) { error in
            if error != nil {
                completion(nil)
            } else {
                completion(newReview)
            }
        }
    }

    // MARK: - get All Reviews By Book (Unused after 22/9) [Thai Le] hjhj xD
    func getAllReviewsByBook(bookID: String, completion: @escaping ([Review]?) -> Void) {
        db.collection("reviews").whereField("bookID", isEqualTo: bookID).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching reviews: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            var result: [Review] = []
            for document in querySnapshot!.documents {
                if let review = try? document.data(as: Review.self) {
                    result.append(review)
                }
            }
            completion(result)
        }
    }
    
    // MARK: - get All Reviews
    func getAllReviews(completion: @escaping ([Review]?) -> Void) {
        db.collection("reviews").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching reviews: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            var result: [Review] = []
            for document in querySnapshot!.documents {
                if let review = try? document.data(as: Review.self) {
                    result.append(review)
                }
            }
            completion(result)
        }
    }
    

    // MARK: - Delete Review
    func deleteReview(reviewID: String, completion: @escaping (Bool?) -> Void) {
        db.collection("reviews").whereField("id", isEqualTo: reviewID).getDocuments { querySnapshot, error in
            if error != nil {
                // Return nil if an error occurs
                completion(false)
            } else {
                // Parse the fetched user data into a User object
                if let document = querySnapshot?.documents.first {
                   let documentID = document.documentID
                    
                    db.collection("reviews").document(documentID).delete { error in
                        if error != nil {
                            // Return failure if an error occurs
                            completion(false)
                        } else {
                            // Otherwise, return success
                            completion(true)
                        }
                    }
                } else {
                    completion(false)
                }
            }
        }
    }
    
    // MARK: - Get all Categories
    func getAllCategories(completion: @escaping (Category?) -> Void) {
        // Get a reference to the Firebase Realtime Database
        let databaseRef = Database.database().reference()

        // Construct the path to the book using the bookID
        let categoriesRef = databaseRef.child("category")
        
        // Retrieve the data at the specified path
        categoriesRef.observe(.childAdded, with: { (snapshot) in
            guard let childData = snapshot.value as? [String: Any] else {
                print("No data found for child node: \(snapshot.key)")
                return
            }
            
            var newCategory: Category = emptyCategory
            
            newCategory.id = childData["id"] as? String ?? ""
            newCategory.name = childData["name"] as? String ?? ""
            newCategory.description = childData["description"] as? String ?? ""
            newCategory.image = childData["image"] as? String ?? ""

            completion(newCategory)
        })
        
    }
    
}
