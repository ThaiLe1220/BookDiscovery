//
//  Category.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 18/09/2023.
//

import Foundation

struct Category {
    var id: String
    var name: String
    var description: String
    var image: String
}

let emptyCategory: Category = Category(
    id: "-1",
    name: "",
    description: "",
    image: ""
)

let testCategory: Category = Category(
    id: "1",
    name: "Art & Photography",
    description: "Book Category Description Testing",
    image: "art-and-photography"
)
