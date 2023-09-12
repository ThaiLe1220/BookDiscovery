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
        print("FirebaseAuthService().signUp() evoked", terminator: ", ")
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(false, error)
                print("failed")
            } else {
                completion(true, nil)
                print("succeed")
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
