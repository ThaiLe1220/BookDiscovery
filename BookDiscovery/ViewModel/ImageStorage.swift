//
//  ImageUploader.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 13/09/2023.
//

import Foundation
import Firebase
import FirebaseStorage
import UIKit

let storage = Storage.storage()

class ImageStorage {
    func uploadProfile(image: UIImage) {
        let userID: String = Auth.auth().currentUser?.uid ?? ""

        let imageRef = storage.reference().child("users/\(userID)/profile.jpg")

        if let imageData = image.jpegData(compressionQuality: 0.8) {
            
            let _ = imageRef.putData(imageData, metadata: nil) { (metadata, error) in
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
    
    func uploadBackground(image: UIImage) {
        let userID: String = Auth.auth().currentUser?.uid ?? ""

        let imageRef = storage.reference().child("users/\(userID)/background.jpg")

        if let imageData = image.jpegData(compressionQuality: 0.8) {
            
            let _ = imageRef.putData(imageData, metadata: nil) { (metadata, error) in
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
    
    func getProfile(completion: @escaping (UIImage?) -> Void) {
        let userID: String = Auth.auth().currentUser?.uid ?? ""
        let imageRef = storage.reference().child("users/\(userID)/profile.jpg")

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

    func getBackground(completion: @escaping (UIImage?) -> Void) {
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

