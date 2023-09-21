//
//  BookListView.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 14/09/2023.
//

import SwiftUI

struct BookListView: View {
    @Binding var isOn: Bool
    @ObservedObject var bookViewModel: BookViewModel
    @ObservedObject var userViewModel: UserViewModel
    @ObservedObject var reviewViewModel: ReviewViewModel

    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(bookViewModel.books, id: \.id) { book in
                    VStack {
                        NavigationLink(destination: BookDetailView(isOn: $isOn, userViewModel: userViewModel, bookViewModel: bookViewModel, reviewViewModel: reviewViewModel, currentBook: book)) {
                            BookView(isOn: $isOn, userViewModel: userViewModel, book: book)
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
        BookListView(isOn: .constant(false), bookViewModel: BookViewModel(), userViewModel: UserViewModel(), reviewViewModel: ReviewViewModel())
    }
}
