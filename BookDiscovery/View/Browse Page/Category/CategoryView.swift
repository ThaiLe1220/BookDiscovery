//
//  CategoryView.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 18/09/2023.
//

import SwiftUI

struct CategoryView: View {
    var category: Category
    @ObservedObject var userViewModel: UserViewModel
    @ObservedObject var bookViewModel: BookViewModel
    @ObservedObject var reviewViewModel: ReviewViewModel
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            VStack (spacing: 0) {
                ZStack {
                    Image(category.image)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 220)
                        .clipped()

                    VStack {
                        Spacer()
                        ZStack {
                            Rectangle()
                                .foregroundColor(Color(UIColor.darkText))
//                                .foregroundColor(Color(UIColor.lightText))
                                .frame(height: 36)
                                .opacity(0.63)
                            
                            Text(category.name)
//                                .foregroundColor(Color(UIColor.darkText).opacity(0.9))
                                .foregroundColor(Color(UIColor.lightText))
                                .font(.system(size: 20, weight: .semibold))
                                .kerning(3) // Adjust the kerning value to your desired spacing

                        }
                    }
                    .frame(height: 220)

                }
                .frame(height: 220)

                
                HStack {
                    Text(category.description)
                        .font(.system(size: 15, weight: .light))
                        .padding(16)
                    Spacer()
                }
                
                Divider()
                
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(bookViewModel.books, id: \.id) { book in
                        if book.category.contains(category.name) {
                            VStack {
                                NavigationLink(destination: BookDetailView(userViewModel: UserViewModel(), bookViewModel: BookViewModel(), reviewViewModel: ReviewViewModel(), currentBook: book)) {
                                    BookView(book: book)
                                }
                                Spacer()
                            }
                        }
                    }

                }
                .padding()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(category: testCategory, userViewModel: UserViewModel(), bookViewModel: BookViewModel(), reviewViewModel: ReviewViewModel())
    }
}
