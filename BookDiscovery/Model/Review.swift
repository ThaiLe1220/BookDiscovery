/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author/Group: 3 - Book Discovery
  Created  date: 15/09/2023
  Last modified: 25/09/2023
  Acknowledgement: N/A
*/

import Foundation

struct Review: Codable, Identifiable, Hashable {
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
    userID: "-1",
    bookID: "-1",
    date: "13/12/2000",
    rating: 5,
    comment: "Test Review 1",
    likes: 0,
    votedUserIds: ["-1"]
)


let testReview2 = Review(
    id: "2",
    userID: "-1",
    bookID: "-1",
    date: "13/12/2000",
    rating: 3,
    comment: "Test Review 2",
    likes: 0,
    votedUserIds: ["2"]
)
