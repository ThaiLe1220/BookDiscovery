//
//  UserModel.swift
//  Book Lover
//
//  Created by Loc Phan Vinh on 11/09/2023.
//

import Foundation

class UserModel:ObservableObject {
    @Published var currentUser: User
    
    init () {
        // TODO: create init() after login
        currentUser = emptyUser
    }
    
    
    func initUser(from dictionary: [String: Any]) {
        self.currentUser.id = dictionary["id"] as? String ?? ""
        self.currentUser.email = dictionary["email"] as? String ?? ""
        self.currentUser.password = dictionary["password"] as? String ?? ""
    }
    
    func toDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary["id"] = self.currentUser.id
        dictionary["email"] = self.currentUser.email
        dictionary["password"] = self.currentUser.password

        return dictionary
    }
}
