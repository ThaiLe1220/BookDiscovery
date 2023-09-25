/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author/Group: 3 - Book Discovery
  Created  date: 18/09/2023
  Last modified: 25/09/2023
  Acknowledgement: N/A
*/

import Foundation

struct Category {
    // MARK: - Attributes
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
