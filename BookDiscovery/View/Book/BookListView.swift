//
//  BookListView.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 14/09/2023.
//

import SwiftUI

struct BookListView: View {
    @ObservedObject var bookViewModel: BookViewModel
    @ObservedObject var reviewViewModel: ReviewViewModel
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(bookViewModel.books, id: \.id) { book in
                    VStack {
                        NavigationLink(destination: BookDetailView(bookViewModel: bookViewModel, reviewViewModel: reviewViewModel, currentBook: book)) {
                            BookView(book: book)
                        }
                        Spacer()
                    }
                }
            }
            .padding()
        }
    }
}

struct BookListView_Previews: PreviewProvider {
    static var previews: some View {
        BookListView(bookViewModel: BookViewModel(), reviewViewModel: ReviewViewModel())
    }
}
