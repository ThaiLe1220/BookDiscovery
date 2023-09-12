//
//  UserModel.swift
//  Book Lover
//
//  Created by Loc Phan Vinh on 11/09/2023.
//

import Foundation

class UserModel: ObservableObject {
    @Published var currentUser: User
    
    init (user: User = emptyUser) {
        // TODO: create init() after login
        currentUser = user
    }
    
    
    func initUser(from dictionary: [String: Any]) {
        self.currentUser.id = dictionary["id"] as? String ?? ""
        self.currentUser.email = dictionary["email"] as? String ?? ""
        self.currentUser.password = dictionary["password"] as? String ?? ""
        
        let address = dictionary["address"] as? [String : Any] ?? [:]
        self.currentUser.address.street = address["street"] as? String ?? ""
        self.currentUser.address.city = address["city"] as? String ?? ""
        self.currentUser.address.country = address["country"] as? String ?? ""
    }
    
    func toDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary["id"] = self.currentUser.id
        dictionary["email"] = self.currentUser.email
        dictionary["password"] = self.currentUser.password
        dictionary["address"] = [
            "street" : self.currentUser.address.street,
            "city" : self.currentUser.address.city,
            "country" : self.currentUser.address.country
        ]
        
        return dictionary
    }
}
