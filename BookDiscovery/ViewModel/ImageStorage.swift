//
//  ImageUploader.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 13/09/2023.
//

// Import required frameworks
import Foundation
import Firebase
import FirebaseStorage
import UIKit

// Initialize Firebase Storage instance
let storage = Storage.storage()

// Define ImageStorage class to manage image upload and download tasks
class ImageStorage {
    
    // MARK: - Upload Profile Image
    // Function to upload profile image to Firebase Storage
    func uploadProfile(image: UIImage) {
        // Fetch current user ID
        let userID: String = Auth.auth().currentUser?.uid ?? ""

        // Create reference to the Firebase Storage location
        let imageRef = storage.reference().child("users/\(userID)/profile.jpg")

        // Convert UIImage to JPEG data
        if let imageData = image.jpegData(compressionQuality: 0.8) {
            
            // Upload the image data to Firebase Storage
            let _ = imageRef.putData(imageData, metadata: nil) { (metadata, error) in
                if let error = error {
                    // Error occurred while uploading
                    print("Error uploading image: \(error.localizedDescription)")
                } else {
                    print("Image uploaded successfully!")
                    
                    // Fetch the download URL of the uploaded image
                    imageRef.downloadURL { (url, error) in
                        if let downloadURL = url {
                            print("Download URL: \(downloadURL)")
                        }
                    }
                }
            }
        }
    }
    
    
    // MARK: - Upload Background Image
    // Function to upload background image to Firebase Storage
    func uploadBackground(image: UIImage) {
        // Similar to uploadProfile, but for background images
        let userID: String = Auth.auth().currentUser?.uid ?? ""
        let imageRef = storage.reference().child("users/\(userID)/background.jpg")

        if let imageData = image.jpegData(compressionQuality: 0.8) {
            let _ = imageRef.putData(imageData, metadata: nil) { (metadata, error) in
                // Error handling and success message are similar to uploadProfile
                if let error = error {
                    print("Error uploading image: \(error.localizedDescription)")
                } else {
                    print("Image uploaded successfully!")
                    
                    imageRef.downloadURL { (url, error) in
                        if let downloadURL = url {
                            print("Download URL: \(downloadURL)")
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Download Profile Image
    // Function to download profile image from Firebase Storage
    func getProfile(completion: @escaping (UIImage?) -> Void) {
        // Fetch current user ID
        let userID: String = Auth.auth().currentUser?.uid ?? ""
        let imageRef = storage.reference().child("users/\(userID)/profile.jpg")

        // Download the image data
        imageRef.getData(maxSize: 10 * 1024 * 1024) { data, error in
            // Error handling and image creation logic
            if let error = error {
                print("Error getting object: \(error.localizedDescription)")
                completion(nil)
            } else {
                if let imageData = data {
                
                    if let image = UIImage(data: imageData) {
                        completion(image)
                    } else {
                        print("Unable to create UIImage from data.")
                        completion(nil)
                    }
                } else {
                    print("No data found.")
                    completion(nil)
                }
            }
        }
    }

    // MARK: - Download Background Image
    // Function to download background image from Firebase Storage
    func getBackground(completion: @escaping (UIImage?) -> Void) {
        // Similar to getProfile, but for background images
        let userID: String = Auth.auth().currentUser?.uid ?? ""
        let imageRef = storage.reference().child("users/\(userID)/background.jpg")

        imageRef.getData(maxSize: 10 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error getting object: \(error.localizedDescription)")
                completion(nil)
            } else {
                if let imageData = data {
                
                    if let image = UIImage(data: imageData) {
                        completion(image)
                    } else {
                        print("Unable to create UIImage from data.")
                        completion(nil)
                    }
                } else {
                    print("No data found.")
                    completion(nil)
                }
            }
        }
    }
}

