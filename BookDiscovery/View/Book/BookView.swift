//
//  BookView.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 14/09/2023.
//

import SwiftUI

struct BookView: View {
    
    
    var body: some View {
        VStack {
            Image("thumbnail")
                .resizable()
                .scaledToFit()
            Text("Book's Name")
            RatingView(rating: 2.5)
                .padding(.horizontal)
        }
        .frame(width: 150)
    }
}
