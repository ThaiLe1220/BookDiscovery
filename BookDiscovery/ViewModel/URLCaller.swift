//
//  URLCaller.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 16/09/2023.
//

import Foundation

class URLCaller {
    @Published var bookName: String = ""
    
    init(name: String = "") {
        let modified_name = name.replacingOccurrences(of: " ", with: "+")
        self.bookName = modified_name
    }
    
    func amazonURL() -> URL? {
        let amazonSearchURLString = "https://www.amazon.com/s?k=\(bookName)"
        return URL(string: amazonSearchURLString)
    }
}

