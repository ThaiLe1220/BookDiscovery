//
//  CategoryListView.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 18/09/2023.
//

import SwiftUI

struct CategoryListView: View {
    @ObservedObject var userViewModel: UserViewModel
    @ObservedObject var bookViewModel: BookViewModel
    @ObservedObject var reviewViewModel: ReviewViewModel
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(bookViewModel.categories, id: \.id) { category in
                    NavigationLink(destination: CategoryView(category: category, userViewModel: userViewModel, bookViewModel: bookViewModel, reviewViewModel: reviewViewModel)) {
                        CategoryCardView(userViewModel: userViewModel, bookViewModel: bookViewModel, reviewViewModel: reviewViewModel, category: category)
                    }
                    .padding(.vertical, 8)
                }
            }
            .padding(.horizontal, 14)
        }
    }
}

struct CategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListView(userViewModel: UserViewModel(), bookViewModel: BookViewModel(), reviewViewModel: ReviewViewModel())
    }
}
