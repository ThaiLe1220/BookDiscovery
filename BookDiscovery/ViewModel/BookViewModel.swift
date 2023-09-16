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
                    for (key, bookInfo) in bookData {
                        if let bookInfo = bookInfo as? [String: Any] {
                            var book: Book = emptyBook
                            
                            book.id = key
                            book.name = bookInfo["name"] as? String ?? ""
                            book.category = bookInfo["category"] as? [String] ?? []
                            book.headline = bookInfo["headline"] as? String ?? ""
                            book.description = bookInfo["description"] as? String ?? ""
                            book.rating = bookInfo["rating"] as? Double ?? 0.0
                            book.totalRated = bookInfo["totalRated"] as? Int ?? 0
                            let author = bookInfo["author"] as? [String : Any] ?? [:]
                            book.author.name = author["name"] as? String ?? ""
                            
                            // Handle image URL
                            if let imageURLString = bookInfo["imageURL"] as? String, let imageURL = URL(string: imageURLString) {
                                book.imageURL = imageURL
                            } else {
                                book.imageURL = nil
                            }
                            
                            self.books[key] = book
                        }
                    }
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
        self.currentBook.totalRated = dictionary["totalRated"] as? Int ?? 0

        let author = dictionary["author"] as? [String : Any] ?? [:]
//        self.currentBook.author.id = author["id"] as? String ?? ""
        self.currentBook.author.name = author["name"] as? String ?? ""
        
        // Handle image URL
        if let imageURLString = dictionary["imageURL"] as? String, let imageURL = URL(string: imageURLString) {
            self.currentBook.imageURL = imageURL
        } else {
            self.currentBook.imageURL = nil
        }
    }
    
    func toDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary["id"] = self.currentBook.id
        dictionary["name"] = self.currentBook.name
        dictionary["category"] = self.currentBook.category
        dictionary["headline"] = self.currentBook.headline
        dictionary["description"] = self.currentBook.description
        dictionary["rating"] = self.currentBook.rating
        dictionary["totalRated"] = self.currentBook.totalRated
        dictionary["author"] = [
//            "id" : self.currentBook.author.id,
            "name" : self.currentBook.author.name
        ]
        
        return dictionary
    }

}
