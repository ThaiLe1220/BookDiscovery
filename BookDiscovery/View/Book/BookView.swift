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
            Image(uiImage: book.image!)
                .resizable()
                .scaledToFit()
                .frame(width: 140, height: 180)
            
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
