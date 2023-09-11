//
//  User.swift
//  Book Lover
//
//  Created by Loc Phan Vinh on 11/09/2023.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable, Identifiable {
    var id: String?
    var email: String
    var password: String
    // Add other properties as needed
    // TODO: Add them struct Address(Country, City, Street)
    // var address: Address
    
    // Initialize from Firestore data
    init(from dictionary: [String: Any]) {
        self.id = dictionary["id"] as? String
        self.email = dictionary["email"] as? String ?? ""
        self.password = dictionary["password"] as? String ?? ""
        
        
//        let street = dictionary["street"] as? String ?? ""
//        let city = dictionary["city"] as? String ?? ""
//        let country = dictionary["country"] as? String ?? ""
//        self.address = Address(street: street, city: city, country: country)
    }

    // Convert to Firestore data
    func toDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary["id"] = self.id
        dictionary["email"] = self.email
        dictionary["password"] = self.password
//        dictionary["street"] = self.address.street
//        dictionary["city"] = self.address.city
//        dictionary["country"] = self.address.country
        return dictionary
    }
}
