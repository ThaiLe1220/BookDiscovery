////
////  BookListView.swift
////  BookDiscovery
////
////  Created by Loc Phan Vinh on 14/09/2023.
////
//
//import SwiftUI
//
//struct BookListView: View {
//    @ObservedObject var bookViewModel: BookViewModel
//    @ObservedObject var reviewViewModel: ReviewViewModel
//
//    let columns = [GridItem(.flexible()), GridItem(.flexible())]
//    
//    @State private var displayedBooksCount = 10
//    @State private var isLoading = false
//    @State var scrollTarget: Int? = nil
//    var totalBooks: [Book] {
//        bookViewModel.books
//    }
//
//
//
//    var body: some View {
//        ScrollViewReader { proxy in
//            ScrollView {
//                LazyVGrid(columns: columns, spacing: 15) {
//                    // Only display 10 books at once
//                    ForEach(totalBooks.sorted().prefix(displayedBooksCount), id: \.self) { bookID in
//                        Button(action: {
//                            if let book = bookViewModel.books[bookID] {
//                                bookViewModel.currentBook = book
//                            }
//                        }) {
//                            NavigationLink(destination: BookDetailView(bookViewModel: bookViewModel, reviewViewModel: reviewViewModel)) {
//                                if let book = bookViewModel.books[bookID] {
//                                    VStack {
//                                        BookView(book: book)
//                                            .onDisappear {
//                                                bookViewModel.currentBook = book
//                                            }
//                                        Spacer()
//                                    }
//                                }
//                            }
//                        }
//                    }
//
//                    // Loading view
//                    if displayedBooksCount < totalBooks.count && isLoading {
//                        HStack {
//                            Spacer()
//                            ProgressView("Loading more...")
//                            Spacer()
//                        }
//                    }
//                }
//                .background(GeometryReader {
//                    Color.clear.preference(key: ViewOffsetKey.self,
//                                           value: -$0.frame(in: .named("scrollView")).origin.y)
//                })
//            }
//            .coordinateSpace(name: "scrollView")
//            .onPreferenceChange(ViewOffsetKey.self) { offset in
//                let threshold = CGFloat(displayedBooksCount) * 100 // Assume each row is 250 points high
//                if offset > threshold && !isLoading {
//                    loadMoreBooks()
//                }
//            }
//        }
//    }
//    
//    
//    // load more book when user scroll to the end of scroll view
//    func loadMoreBooks() {
//        isLoading = true
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            displayedBooksCount += min(10, totalBooks.count - displayedBooksCount)
//            isLoading = false
//        }
//    }
//}
//
//struct BookListView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookListView(bookViewModel: BookViewModel(), reviewViewModel: ReviewViewModel())
//    }
//}
