//
//  BookViewModel.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 14/09/2023.
//

import Foundation
import FirebaseDatabase

class BookViewModel: ObservableObject {
    @Published var currentBook: Book
    @Published var books: [String: Book] = [:]

    init (book: Book = emptyBook) {
        currentBook = book
        initAllBooks()
    }
    
    func initAllBooks() {
        FireBaseDB().getAllBooks() { result in
            DispatchQueue.main.async {
                if let bookData = result {
                    let key = Array(bookData.keys)[0]
                    let bookInfo = bookData[key] as? [String: Any]
                    var book: Book = emptyBook
                    
                    book.id = key
                    book.name = bookInfo!["name"] as? String ?? ""
                    book.category = bookInfo!["category"] as? String ?? ""
                    book.headline = bookInfo!["headline"] as? String ?? ""
                    book.description = bookInfo!["description"] as? String ?? ""
                    book.price = bookInfo!["price"] as? Double ?? 0.0
                    book.rating = bookInfo!["rating"] as? Double ?? 0.0

                    let author = bookInfo!["author"] as? [String : Any] ?? [:]
                    book.author.name = author["name"] as? String ?? ""
                    
                    self.books[key] = book
                }
            }
        }
    }
    
    func initBook(from dictionary: [String: Any]) {
        self.currentBook.id = dictionary["id"] as? String ?? ""
        self.currentBook.name = dictionary["name"] as? String ?? ""
        self.currentBook.category = dictionary["category"] as? String ?? ""
        self.currentBook.headline = dictionary["headline"] as? String ?? ""
        self.currentBook.description = dictionary["description"] as? String ?? ""
        
        self.currentBook.price = dictionary["price"] as? Double ?? 0.0
        self.currentBook.rating = dictionary["rating"] as? Double ?? 0.0


        let author = dictionary["author"] as? [String : Any] ?? [:]
//        self.currentBook.author.id = author["id"] as? String ?? ""
        self.currentBook.author.name = author["name"] as? String ?? ""
    }
    
    func toDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary["id"] = self.currentBook.id
        dictionary["name"] = self.currentBook.name
        dictionary["category"] = self.currentBook.category
        dictionary["headline"] = self.currentBook.headline
        dictionary["description"] = self.currentBook.description

        dictionary["price"] = self.currentBook.price
        dictionary["rating"] = self.currentBook.rating

        dictionary["author"] = [
//            "id" : self.currentBook.author.id,
            "name" : self.currentBook.author.name
        ]
        
        return dictionary
    }

}
