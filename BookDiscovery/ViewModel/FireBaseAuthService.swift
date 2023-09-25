/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author/Group: 3 - Book Discovery
  Created  date: 11/09/2023
  Last modified: 25/09/2023
  Acknowledgement: N/A
*/

// Import required frameworks
import Foundation
import Firebase
import LocalAuthentication

// Define FirebaseAuthService class to manage authentication tasks
class FirebaseAuthService {
    
    // MARK: - Sign Up
    // Function to create a new user account with email and password
    func signUp(email: String, password: String, name: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                // Sign-up failed, pass error to completion
                completion(false, error)
            } else if let user = result?.user {
                // User created, now add to Firestore database
                let userID = user.uid
                FireBaseDB().addUser(userID: userID, userEmail: email, userName: name) { _ in }
                completion(true, nil)
            }
        }
    }
    
    // MARK: - Sign In
    // Function to sign in existing user with email and password
    func signIn(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                // Sign-in failed, pass error to completion
                completion(false, error)
            } else {
                // Successfully signed in
                completion(true, nil)
            }
        }
    }
    
    // MARK: - Sign Out
    // Function to sign out the current user
    func signOut(completion: @escaping (Bool, Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true, nil)
        } catch let signOutError as NSError {
            // Sign-out failed, pass error to completion
            print("Error signing out: \(signOutError.localizedDescription)")
            completion(false, signOutError)
        }
    }

    // MARK: - Change Password
    // Function to change the password of the current user
    func changePassword(currentPassword: String, newPassword: String, completion: @escaping (Bool, Error?) -> Void) {
        let user = Auth.auth().currentUser
        let credential = EmailAuthProvider.credential(withEmail: user?.email ?? "", password: currentPassword)
        
        // Re-authenticate the user with the current credentials
        user?.reauthenticate(with: credential) { _, error in
            if let error = error {
                // Re-authentication failed, pass error to completion
                completion(false, error)
            } else {
                // Update password
                user?.updatePassword(to: newPassword) { error in
                    if let error = error {
                        // Password change failed, pass error to completion
                        completion(false, error)
                    } else {
                        // Successfully changed password
                        completion(true, nil)
                    }
                }
            }
        }
    }
    
    // MARK: - Reset Password
    func resetPassword(email: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                completion(false, error)
            } else {
                completion(true, nil)
            }
        }
    }
    
    // MARK: - Biometric Authentication
    // Function to handle biometric authentication (Face ID/Touch ID)
    func biometricAuthentication(completion: @escaping (Bool, Error?) -> Void) {
        let context = LAContext()
        var error: NSError?
        
        // Check if device supports biometric authentication
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // Evaluate policy for biometric authentication
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "This is for security reasons") { success, authenticationError in
                if success {
                    // Biometric authentication successful
                    print("Face ID Confirmed. User Signed In.")
                    completion(true, nil)
                } else {
                    // Biometric authentication failed
                    print("Face ID not found. Please try again.")
                    completion(false, error)
                }
            }
        } else {
            // Device does not support biometric authentication
            print("Device does not have biometrics!")
        }
    }

}
