//
//  BookListView.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 14/09/2023.
//

import SwiftUI

struct BookListView: View {
    @StateObject var bookViewModel: BookViewModel = BookViewModel()
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(bookViewModel.books.keys.sorted(), id: \.self) { bookID in

                    if let book = bookViewModel.books[bookID] {
                        VStack {
                            BookView(bookID: bookID,  bookName: book.name, bookRating: book.rating, bookReviews: 100, imageURL: book.imageURL)
                            Spacer()
                        }
                    }
                }
            }
            .padding()
        }
    }
}

struct BookListView_Previews: PreviewProvider {
    static var previews: some View {
        BookListView()
    }
}
