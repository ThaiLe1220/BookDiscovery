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

import SwiftUI

struct BookListView: View {
    @ObservedObject var bookViewModel: BookViewModel
    @ObservedObject var userViewModel: UserViewModel
    @ObservedObject var reviewViewModel: ReviewViewModel

    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(bookViewModel.books, id: \.id) { book in
                    VStack {
                        NavigationLink(destination: BookDetailView(userViewModel: userViewModel, bookViewModel: bookViewModel, reviewViewModel: reviewViewModel, currentBook: book)) {
                            BookView(userViewModel: userViewModel, book: book)
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
        BookListView(bookViewModel: BookViewModel(), userViewModel: UserViewModel(), reviewViewModel: ReviewViewModel())
    }
}
