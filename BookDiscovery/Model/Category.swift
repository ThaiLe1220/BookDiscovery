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
}

let emptyCategory: Category = Category(
    id: "-1",
    name: "",
    description: ""
)

let testCategory: Category = Category(
    id: "1",
    name: "Category 1",
    description: "Description 1"
)
