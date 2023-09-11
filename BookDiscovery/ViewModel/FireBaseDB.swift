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

let db = Firestore.firestore()

// MARK: - Add User
func addUser(user: User, completion: @escaping (Bool) -> Void) {
    db.collection("users")
        .whereField("email", isEqualTo: user.email)
        .getDocuments { querySnapshot, error in
            if error != nil {
                completion(false)
            } else {
                if let _ = querySnapshot?.documents.first {
                    completion(false)
                } else {
                    // Username is unique; add the user
                    var userData = user.toDictionary()
                    userData.removeValue(forKey: "id")
                    
                    db.collection("users").addDocument(data: userData) { error in
                        if error != nil {
                            completion(false)
                        } else {
                            completion(true)
                        }
                    }
                }
            }
        }
}


// MARK: - Read
func fetchUserByUsername(email: String, completion: @escaping (User?) -> Void) {
    db.collection("users")
        .whereField("email", isEqualTo: email)
        .getDocuments { querySnapshot, error in
            if error != nil {
                completion(nil)
            } else {
                if let document = querySnapshot?.documents.first,
                   var user = try? document.data(as: User.self) {
                    user.id = document.documentID
                    completion(user)
                } else {
                    completion(nil)
                }
            }
        }
}

// MARK: - Update
func updateUser(user: User, completion: @escaping (Bool) -> Void) {
    if let userID = user.id {
        var userData = user.toDictionary()
        userData.removeValue(forKey: "id")
        db.collection("users").document(userID).setData(userData) { error in
            if error != nil {
                completion(false)
            } else {
                completion(true)
            }
        }
    } else {
        completion(false)
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

