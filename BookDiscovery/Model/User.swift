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
    var address: Address
}

let emptyUser = User(id: "", email: "", password: "", address: Address(street: "", city: "", country: ""))
