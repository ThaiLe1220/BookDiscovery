//
//  UserModel.swift
//  Book Lover
//
//  Created by Loc Phan Vinh on 11/09/2023.
//

import Foundation

class UserViewModel: ObservableObject {
    @Published var currentUser: User
    @Published var isSignedIn: Bool = false

    init (user: User = emptyUser) {
        currentUser = user
    }
    
    
    func initUser(from dictionary: [String: Any]) {
        self.currentUser.id = dictionary["id"] as? String ?? ""
        self.currentUser.email = dictionary["email"] as? String ?? ""
        self.currentUser.name = dictionary["name"] as? String ?? ""
        
        let address = dictionary["address"] as? [String : Any] ?? [:]
        self.currentUser.address.street = address["street"] as? String ?? ""
        self.currentUser.address.city = address["city"] as? String ?? ""
        self.currentUser.address.country = address["country"] as? String ?? ""
        
        self.currentUser.bio = dictionary["bio"] as? String ?? ""
    }
    
    func toDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary["id"] = self.currentUser.id
        dictionary["email"] = self.currentUser.email
        dictionary["name"] = self.currentUser.name
        dictionary["address"] = [
            "street" : self.currentUser.address.street,
            "city" : self.currentUser.address.city,
            "country" : self.currentUser.address.country
        ]
        dictionary["bio"] = self.currentUser.bio
        
        return dictionary
    }
}
