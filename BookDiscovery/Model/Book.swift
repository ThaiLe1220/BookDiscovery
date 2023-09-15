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

let testBook = Book(
    id: "0",
    name: "Dune Official Movie Graphic Novel",
    category: "Art & Photography",
    headline: "Frank Herbert’s classic masterpiece—a triumph of the imagination and one of the bestselling science fiction novels of all time.",
    price: 10.0,
    rating: 3.8,
    description: "Set on the desert planet Arrakis, Dune is the story of Paul Atreides—who would become known as Muad'Dib—and of a great family's ambition to bring to fruition mankind's most ancient and unattainable dream.A stunning blend of adventure and mysticism, environmentalism and politics, Dune won the first Nebula Award, shared the Hugo Award, and formed the basis of what is undoubtedly the grandest epic in science fiction.",
    imageURL: nil,
    author: Author(
        name: "Lilah Sturges"
    )
)

