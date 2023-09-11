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
    
    func signIn(completion: @escaping (Bool, Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true, nil)
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError.localizedDescription)")
            completion(false, signOutError)

        }
    }

}
