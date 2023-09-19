//
//  HomeView.swift
//  BookDiscovery
//
//  Created by Thai, Le Hong on 14/09/2023.
//

import SwiftUI

struct HomeView: View {
    @Binding var isOn: Bool
    @ObservedObject var userViewModel: UserViewModel
    @ObservedObject var bookViewModel: BookViewModel
    @ObservedObject var reviewViewModel: ReviewViewModel

    let banners = ["Banner1", "Banner2", "Banner1", "Banner2", "Banner1", "Banner2"]
    @State private var currentPage: Int = 0
    @State private var offset: CGFloat = 0
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    @State private var displayedBooksCount = 10
    @State private var isLoading = false
    @State var scrollTarget: Int? = nil
    var totalBooks: [Book] {
        bookViewModel.books
    }

    // Dummy data for the example
    let recommendedBooks: [Book] = [testBook1, testBook, testBook1, testBook]
    let continueReadingBooks: [Book] = [/* your array of Book objects user is currently reading */]
    let hotReviews: [Review] = [/* your array of hot Review objects */]
    let popularBooks: [Book] = [/* your array of popular Book objects */]
    let categories: [String] = ["Science Fiction", "Romance", "Thrillers", "Non-fiction"]
    let newReleases: [Book] = [/* your array of newly released Book objects */]
    let editorsPick: [Book] = [/* your array of editor's pick Book objects */]

    
    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView {
                    GeometryReader { geometry in
                        ZStack {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 0) {
                                    ForEach(banners, id: \.self) { banner in
                                        Image(banner)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: geometry.size.width, height: 200)
                                    }
                                }
                            }
                            .content.offset(x: self.offset)
                            .frame(width: geometry.size.width, alignment: .leading)
                            .gesture(
                                DragGesture()
                                    .onEnded { value in
                                        let threshold = geometry.size.width / 4
                                        if value.translation.width < -threshold {
                                            self.currentPage = min(self.currentPage + 1, self.banners.count - 1)
                                        } else if value.translation.width > threshold {
                                            self.currentPage = max(self.currentPage - 1, 0)
                                        }
                                        
                                        withAnimation {
                                            self.offset = -CGFloat(self.currentPage) * geometry.size.width
                                        }
                                    }
                            )
                            .onAppear {
                                Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
                                    withAnimation {
                                        self.currentPage = (self.currentPage + 1) % self.banners.count
                                        self.offset = -CGFloat(self.currentPage) * geometry.size.width
                                    }
                                }
                            }
                            
                            HStack (spacing: 0) {
                                ForEach(0..<banners.count, id: \.self) { index in
                                    ZStack {
                                        Image(systemName: "circlebadge.fill")
                                            .resizable()
                                            .foregroundColor(.white.opacity(0.001))
                                        
                                        Circle()
                                            .frame(width: 8, height: 8)
                                            .foregroundColor(currentPage == index ? Color.gray : Color(UIColor.systemGray5))
                                    }
                                    .frame(width: 20, height: 20)
                                    .onTapGesture {
                                        withAnimation {
                                            self.currentPage = index
                                            self.offset = -CGFloat(self.currentPage) * UIScreen.main.bounds.width
                                        }
                                    }
                                }
                            }
                            .offset(y: 75)
                        }
                    }
                    .frame(height: 180)  // 200 for image and 20 for the dots
                    
                    HStack {
                        Text("Recommened Books")
                            .padding(.horizontal)
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(Color("OrangeMain"))
                        Spacer()
                    }
                    .padding(.bottom, -2)
                    .padding(.top)
                    
                    LazyVGrid(columns: columns, spacing: 15) {
                        // Only display 10 books at once
                        ForEach(Array(totalBooks.prefix(displayedBooksCount)), id: \.self) { tempBook in
                            Button(action: {
//
                            }) {
                                NavigationLink(destination: BookDetailView(userViewModel: userViewModel, bookViewModel: bookViewModel, reviewViewModel: reviewViewModel, currentBook: tempBook)) {
                                    VStack {
                                        BookView(book: tempBook)

                                        Spacer()
                                    }
                                    
                                }
                            }
                        }
                    }
                    .background(GeometryReader {
                        Color.clear.preference(key: ViewOffsetKey.self,
                                               value: -$0.frame(in: .named("scrollView")).origin.y)
                    })
                    
                    // Loading view
                    if displayedBooksCount < totalBooks.count && isLoading {
                        HStack {
                            Spacer()
                            ProgressView("Loading more...")
                            Spacer()
                        }
                        .padding()
                    }
                    
                }
                .coordinateSpace(name: "scrollView")
                .onPreferenceChange(ViewOffsetKey.self) { offset in
                    let threshold = CGFloat(displayedBooksCount) * 63 // Assume each row is 250 points high
                    if offset > threshold && !isLoading {
                        loadMoreBooks()
                    }
                }
            }
        }
        .background(Color(UIColor.secondarySystemBackground))
        .frame(height: UIScreen.main.bounds.height-150)
        .ignoresSafeArea()
    }
    
    // load more book when user scroll to the end of scroll view
    func loadMoreBooks() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            displayedBooksCount += min(10, totalBooks.count - displayedBooksCount)
            isLoading = false
        }
    }
}


struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(isOn: .constant(false), userViewModel: UserViewModel(), bookViewModel: BookViewModel(), reviewViewModel: ReviewViewModel())
    }
}
