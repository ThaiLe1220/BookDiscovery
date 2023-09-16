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
        VStack (spacing: 2.5) {
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
                .frame(width: 140, height: 180)
            } else {
                Image("thumbnail")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 180)
            }
            Text(book.name)
                .font(.system(size: 15))
                .lineLimit(2)
                .frame(height: 38)

            RatingView(rating: book.rating)
                .frame(height: 12)
        }
        .frame(width: 160, height: 235)
        
    }
}


struct BookView_Previews: PreviewProvider {
    static var previews: some View {
        BookView(book: testBook)
    }
}
