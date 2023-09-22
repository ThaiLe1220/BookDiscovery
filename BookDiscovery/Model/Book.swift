//
//  Book.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 14/09/2023.
//

import Foundation
import UIKit

struct Book: Codable, Identifiable, Hashable {
    var id: String
    var name: String
    var category: [String]
    var headline: String
    var rating: Double
    var description: String
    var imageURL: String
    var author: Author
    var image: UIImage? {
        
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let imageUrl = documentsDirectory.appendingPathComponent("book-\(id).jpg")

            if let loadedImage = UIImage(contentsOfFile: imageUrl.path) {
                return loadedImage
            }
            
            guard let url = URL(string: imageURL) else { return UIImage(named: "thumbnail") }
            
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let data = data, error == nil {
                    if let uiImage = UIImage(data: data) {

                        if let data = uiImage.jpegData(compressionQuality: 1.0) {
                            if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                                let fileURL = documentsDirectory.appendingPathComponent("book-\(id).jpg")
                                do {
                                    try data.write(to: fileURL)
                                    print("Image saved at: \(fileURL)")
                                } catch {
                                    print("Error saving image: \(error)")
                                }
                            }
                        }
                    }
                }
            }.resume()
            
            let newImageUrl = documentsDirectory.appendingPathComponent("book-\(id).jpg")
            
            if let reloadedImage = UIImage(contentsOfFile: newImageUrl.path) {
                return reloadedImage
            }
        }

        return UIImage(named: "thumbnail")
    }
    
    
    // Conformance to Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id) // Assuming 'id' is unique for each book
        // You can add more properties if needed
    }

    static func == (lhs: Book, rhs: Book) -> Bool {
        return lhs.id == rhs.id // Compare based on 'id'
        // You can add more properties if needed
    }
}

let emptyBook = Book(
    id: "",
    name: "",
    category: [""],
    headline: "",
    rating: 0.0,
    description: "",
    imageURL: "",
    author: Author(
        name: ""
    )
)

let testBook = Book(
    id: "-1",
    name: "Dune Official Movie Graphic Novel",
    category: ["Art & Photography"],
    headline: "Frank Herbert’s classic masterpiece—a triumph of the imagination and one of the bestselling science fiction novels of all time.",
    rating: 3.8,
    description: "Set on the desert planet Arrakis, Dune is the story of Paul Atreides—who would become known as Muad'Dib—and of a great family's ambition to bring to fruition mankind's most ancient and unattainable dream.A stunning blend of adventure and mysticism, environmentalism and politics, Dune won the first Nebula Award, shared the Hugo Award, and formed the basis of what is undoubtedly the grandest epic in science fiction.",
    imageURL: "",
    author: Author(
        name: "Lilah Sturges"
    )
)


let testBook1 = Book(
    id: "-2",
    name: "Dune Official Movie Graphic Novel",
    category: ["ScienceFiction"],
    headline: "Frank Herbert’s classic masterpiece—a triumph of the imagination and one of the bestselling science fiction novels of all time.",
    rating: 3.8,
    description: "Set on the desert planet Arrakis, Dune is the story of Paul Atreides—who would become known as Muad'Dib—and of a great family's ambition to bring to fruition mankind's most ancient and unattainable dream.A stunning blend of adventure and mysticism, environmentalism and politics, Dune won the first Nebula Award, shared the Hugo Award, and formed the basis of what is undoubtedly the grandest epic in science fiction.",
    imageURL: "",
    author: Author(
        name: "Lilah Sturges"
    )
)
