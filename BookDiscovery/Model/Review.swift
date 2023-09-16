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
    var likes: Int
    var votedUserIds: [String]
}

let emptyReview = Review(
    id: "",
    userID: "",
    bookID: "",
    date: "",
    rating: 0.0,
    comment: "",
    likes: 0,
    votedUserIds: []

)

let testReview1 = Review(
    id: "1",
    userID: "User ID/Username 1",
    bookID: "Current Book ID",
    date: "",
    rating: 5,
    comment: "Test Review 1",
    likes: 0,
    votedUserIds: ["1"]
)


let testReview2 = Review(
    id: "2",
    userID: "User ID/Username 2",
    bookID: "Current Book ID",
    date: "",
    rating: 3,
    comment: "Test Review 2",
    likes: 0,
    votedUserIds: ["2"]

)
