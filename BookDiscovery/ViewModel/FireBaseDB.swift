//
//  FireBaseDB.swift
//  Book Lover
//
//  Created by Loc Phan Vinh on 11/09/2023.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseDatabase


let db = Firestore.firestore()


class FireBaseDB {
    // MARK: - Add User
    func addUser(userID: String, userEmail: String, completion: @escaping (Bool) -> Void) {
        db.collection("users").addDocument(data: ["id" : userID, "email" : userEmail]) { error in
            if error != nil {
                completion(false)
            } else {
                completion(true)
            }
        }
    }


    // MARK: - Read
    func fetchUser(userID: String, completion: @escaping (User?) -> Void) {
        db.collection("users")
            .whereField("id", isEqualTo: userID)
            .getDocuments { querySnapshot, error in
                if error != nil {
                    completion(nil)
                } else {
                    if let document = querySnapshot?.documents.first,
                       let user = try? document.data(as: User.self) {
                        completion(user)
                    } else {
                        completion(nil)
                        
                    }
                }
            }
    }

    // MARK: - Update
    func updateUser(user: User, completion: @escaping (Bool) -> Void) {
        let userEmail = user.email

        let userData = UserModel(user: user).toDictionary()
        
        db.collection("users").whereField("email", isEqualTo: userEmail).getDocuments { (querySnapshot, error) in
            if error != nil{
                completion(false)
            } else {
                if let document = querySnapshot?.documents.first {
                    let userID = document.documentID
                    db.collection("users").document(userID).setData(userData) { error in
                        if error != nil {
                            completion(false)
                        } else {
                            completion(true)
                        }
                    }
                } else {
                    print("User with email \(userEmail) not found.")
                    completion(false)
                }
            }
        }
    }



    // MARK: - Delete
    func deleteUser(userID: String, completion: @escaping (Bool) -> Void) {
        db.collection("users").document(userID).delete { error in
            if error != nil {
                completion(false)
            } else {
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

            completion(childData)
        })
    }
}
