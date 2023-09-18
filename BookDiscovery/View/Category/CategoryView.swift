//
//  CategoryView.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 18/09/2023.
//

import SwiftUI

struct CategoryView: View {
    var category: Category = testCategory
    @State var books: [Book] = [testBook, testBook1]
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            VStack {
                ZStack {
                    Image(category.image)
                        .resizable()
                        .scaledToFit()
                        
                    VStack {
                        Spacer()
                        ZStack {
                            Rectangle()
                                .foregroundColor(.white)
                                .frame(height: 30)
                                .opacity(0.8)
                            Text(category.name)
                        }
                        
                    }
                    
                }
                
                
                Text(category.description)
                    .padding()
                
                Divider()
                
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(books, id: \.id) { book in
                        if book.category[0] != category.name {
                            VStack {
                                BookView(book: book)
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
        CategoryView()
    }
}
