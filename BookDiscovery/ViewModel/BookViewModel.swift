/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author/Group: 3 - Book Discovery
  Created  date: 14/09/2023
  Last modified: 25/09/2023
  Acknowledgement: N/A
*/

import Foundation
import FirebaseDatabase
import UIKit

class BookViewModel: ObservableObject {
    // MARK: - Attributes
    @Published var currentBook: Book
    @Published var categories: [Category] = []
    @Published var books: [Book] = []
    @Published var loves: [Book] = []

    // MARK: - Constructor
    init () {
        currentBook = emptyBook
        initAllBooks()
        initAllCategories()
    }
    
    // MARK: - Get all books
    func initAllBooks() {
        FireBaseDB().getAllBooks() { result in
            DispatchQueue.main.async {
                if let bookData = result {
                    self.books.append(bookData)
                }
            }
        }
    }
    
    // MARK: - Get all categories
    func initAllCategories() {
        FireBaseDB().getAllCategories() { result in
            DispatchQueue.main.async {
                if let categoryData = result {
                    self.categories.append(categoryData)
                }
            }
        }
    }
    
    
    func initBook(from dictionary: [String: Any]) {
        self.currentBook.id = dictionary["id"] as? String ?? ""
        self.currentBook.name = dictionary["name"] as? String ?? ""
        self.currentBook.category = dictionary["category"] as? [String] ?? []
        self.currentBook.headline = dictionary["headline"] as? String ?? ""
        self.currentBook.description = dictionary["description"] as? String ?? ""
        self.currentBook.rating = dictionary["rating"] as? Double ?? 0.0
        self.currentBook.imageURL = dictionary["imageURL"] as? String ?? ""
        self.currentBook.author = dictionary["author"] as? String ?? ""
    }
    
    func toDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary["id"] = self.currentBook.id
        dictionary["name"] = self.currentBook.name
        dictionary["category"] = self.currentBook.category
        dictionary["headline"] = self.currentBook.headline
        dictionary["description"] = self.currentBook.description
        dictionary["rating"] = self.currentBook.rating
        dictionary["author"] = self.currentBook.author
        return dictionary
    }
    
    // MARK: - Get book with ID
    func get(bookID: String) -> Book {
        for book in self.books {
            if book.id == bookID {
                return book
            }
        }
        
        return emptyBook
    }

    
}
