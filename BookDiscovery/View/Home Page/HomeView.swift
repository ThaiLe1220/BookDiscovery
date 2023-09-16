//
//  HomeView.swift
//  BookDiscovery
//
//  Created by Thai, Le Hong on 14/09/2023.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var userViewModel: UserViewModel
    
    @State private var currentPage: Int = 0
    @State private var offset: CGFloat = 0
    let banners = ["Banner1", "Banner2", "Banner1", "Banner2", "Banner1", "Banner2"]
    
    // Dummy data for the example
    let recommendedBooks: [Book] = [testBook1, testBook, testBook1, testBook]
    let continueReadingBooks: [Book] = [/* your array of Book objects user is currently reading */]
    let hotReviews: [Review] = [/* your array of hot Review objects */]
    let popularBooks: [Book] = [/* your array of popular Book objects */]
    let categories: [String] = ["Science Fiction", "Romance", "Thrillers", "Non-fiction"]
    let newReleases: [Book] = [/* your array of newly released Book objects */]
    let editorsPick: [Book] = [/* your array of editor's pick Book objects */]

    
    var body: some View {
        NavigationStack {
            VStack {
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
                                Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
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
                    .frame(height: 220)  // 200 for image and 20 for the dots

//                    ScrollView(.horizontal, showsIndicators: false) {
//                        HStack(spacing: 8) {
//                            ForEach(recommendedBooks) { book in
//                                BookView(book: book)
//                            }
//                        }
//                    }
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(recommendedBooks.indices, id: \.self) { index in
                            BookView(book: recommendedBooks[index])
//                                .frame(height: index % 2 == 0 ? 200 : 300)
                                .frame(height: 240 )
                        }
                    }

                }
                

            }
            .background(Color(UIColor.secondarySystemBackground))
        }
        .frame(height: UIScreen.main.bounds.height-150)
        .ignoresSafeArea()
        .border(.black)
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(userViewModel: UserViewModel())
    }
}
