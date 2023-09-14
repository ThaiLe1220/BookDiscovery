//
//  FireBaseAuthentication.swift
//  BookDiscovery
//
//  Created by Huy Hua Nam on 11/09/2023.
//

import Foundation
import Firebase
import LocalAuthentication

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
    
    func resetPassword(email: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                completion(false, error)
            } else {
                completion(true, nil)
            }
        }
    }
    
    func biometricAuthentication() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "This is for security reasons") { success, authenticationError in
                
                if success {
                    print("Face ID Confirmed. User Signed In.")
                } else {
                    print("Face ID not found. Please try again.")
                }
            }
        } else {
            print("Device does not have biometrics!")
        }
    }

}
