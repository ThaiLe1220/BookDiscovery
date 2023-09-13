import Foundation

struct Book {
    var id: String
    var name: String
    var category: String
    var headline: String
    var price: Double
    var rating: Double
    var description: String
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
    author: Author(
        id:"",
        name: ""
    )
)