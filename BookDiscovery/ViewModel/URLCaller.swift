/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author/Group: 3 - Book Discovery
  Created  date: 16/09/2023
  Last modified: 25/09/2023
  Acknowledgement: N/A
*/

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

