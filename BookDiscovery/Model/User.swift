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
    var name: String
    var address: Address
    var bio: String
}

let emptyUser = User(id: "", email: "", name: "", address: Address(street: "", city: "", country: ""), bio: "")
