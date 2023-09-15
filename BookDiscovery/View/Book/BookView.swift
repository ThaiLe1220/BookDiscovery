//
//  BookView.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 14/09/2023.
//

import SwiftUI

struct BookView: View {
    var book: Book
    var bookReviews: Int = 100
    
    var body: some View {
        Button {
            print(book.id ?? "")
        } label: {
            VStack {
                if let imageURL = book.imageURL {
                    AsyncImage(url: imageURL) { phase in
                        switch phase {
                        case .empty:
                            Text("LOADING\nCOVER IMAGE")
                            
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                            
                        case .failure:
                            Image("cover_unavailable")
                                .resizable()
                                .scaledToFit()
                            
                        @unknown default:
                            // Handle unknown cases
                            Text("WTF HAPPENED")
                        }
                    }
                    .frame(width: 180, height: 250)
                } else {
                    Image("thumbnail")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180, height: 250)
                }
//                Image("thumbnail")
//                    .resizable()
//                    .scaledToFit()
                Text(book.name)
                    .lineLimit(2)
                RatingView(rating: book.rating)
                    .frame(width: 125)
                Text("Reviews: \(bookReviews)")
            }
            .frame(width: 150)
            .padding()
        }
        
    }
}


struct BookView_Previews: PreviewProvider {
    static var previews: some View {
        BookView(book: testBook)
    }
}
