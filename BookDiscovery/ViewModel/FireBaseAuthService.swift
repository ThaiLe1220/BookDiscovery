//
//  FireBaseAuthentication.swift
//  BookDiscovery
//
//  Created by Huy Hua Nam on 11/09/2023.
//

import Foundation
import Firebase

class FirebaseAuthService {
    func signUp(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(false, error)
            } else if let user = result?.user {
                let userID = user.uid
                FireBaseDB().addUser(userID: userID, userEmail: email) { _ in }
                completion(true, nil)
            }
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(false, error)
            } else {
                completion(true, nil)
            }
        }
    }
    
    func signOut(completion: @escaping (Bool, Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true, nil)
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError.localizedDescription)")
            completion(false, signOutError)

        }
    }

    func changePassword(currentPassword: String, newPassword: String, completion: @escaping (Bool, Error?) -> Void) {
        let user = Auth.auth().currentUser
        let credential = EmailAuthProvider.credential(withEmail: user?.email ?? "", password: currentPassword)
        
        user?.reauthenticate(with: credential) { _, error in
            if let error = error {
                completion(false, error)
            } else {
                user?.updatePassword(to: newPassword) { error in
                    if let error = error {
                        completion(false, error)
                    } else {
                        completion(true, nil)
                    }
                }
            }
        }
    }

}
