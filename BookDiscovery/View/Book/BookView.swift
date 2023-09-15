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
    var imageURL: URL?
    
    var body: some View {
        Button {
            print(bookID)
        } label: {
            VStack {
                if let imageURL = imageURL {
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
                Text(bookName)
                    .lineLimit(2)
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
