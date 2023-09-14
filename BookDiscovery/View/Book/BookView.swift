//
//  BookView.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 14/09/2023.
//

import SwiftUI

struct BookView: View {
    var bookID: String
    var bookName: String
    var bookRating: Double
    var bookReviews: Int
    
    var body: some View {
        Button {
            print(bookID)
        } label: {
            VStack {
                Image("thumbnail")
                    .resizable()
                    .scaledToFit()
                Text(bookName)
                RatingView(rating: bookRating)
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
        BookView(bookID: "1", bookName: "", bookRating: 4.0, bookReviews: 1)
    }
}
