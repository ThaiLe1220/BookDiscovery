//
//  Review.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 15/09/2023.
//

import Foundation

struct Review: Codable {
    var id: String
    var userID: String
    var bookID: String
    var date: String
    var rating: Double
    var comment: String
}

let emptyReview = Review(
    id: "",
    userID: "",
    bookID: "",
    date: "",
    rating: 0.0,
    comment: ""
)

let testReview1 = Review(
    id: "1",
    userID: "User ID/Username 1",
    bookID: "Current Book ID",
    date: "",
    rating: 3.5,
    comment: "This is a comment from user 1"
)


let testReview2 = Review(
    id: "2",
    userID: "User ID/Username 2",
    bookID: "Current Book ID",
    date: "",
    rating: 4,
    comment: "This is a comment from user 2"
)
