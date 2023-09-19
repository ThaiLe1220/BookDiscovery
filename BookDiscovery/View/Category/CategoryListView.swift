//
//  CategoryListView.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 18/09/2023.
//

import SwiftUI

struct CategoryListView: View {
    @StateObject var categoryViewModel: CategoryViewModel = CategoryViewModel()
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(categoryViewModel.categories, id: \.id) { category in
                    CategoryCardView(category: category)
                    .padding(10)
                }
            }
            .padding()
        }
    }
}

struct CategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListView()
    }
}
