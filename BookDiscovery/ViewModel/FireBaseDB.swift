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

}
