//
//  Book.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 14/09/2023.
//

import Foundation

struct Book: Codable, Identifiable {
    var id: String?
    var name: String
    var category: String
    var headline: String
    var price: Double
    var rating: Double
    var description: String
    var imageURL: URL?
    var author: Author
}

let emptyBook = Book(
    id: "",
    name: "",
    category: "",
    headline: "",
    price: 0.0,
    rating: 0.0,
    description: "",
    imageURL: nil,
    author: Author(
        name: ""
    )
)
