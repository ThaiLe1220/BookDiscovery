//
//  CategoryCardView.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 19/09/2023.
//

import SwiftUI

struct CategoryCardView: View {
    var category: Category
    
    var body: some View {
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
    }
}
