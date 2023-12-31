/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author/Group: 3 - Book Discovery
  Created  date: 18/09/2023
  Last modified: 25/09/2023
  Acknowledgement: N/A
*/

import SwiftUI

struct CategoryListView: View {
    // MARK: - Variables
    @ObservedObject var userViewModel: UserViewModel
    @ObservedObject var bookViewModel: BookViewModel
    @ObservedObject var reviewViewModel: ReviewViewModel
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    // MARK: - Main View
    var body: some View {
        // MARK: - List of categories
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
