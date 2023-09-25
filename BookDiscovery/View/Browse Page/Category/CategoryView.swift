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

struct CategoryView: View {
    var category: Category
    @ObservedObject var userViewModel: UserViewModel
    @ObservedObject var bookViewModel: BookViewModel
    @ObservedObject var reviewViewModel: ReviewViewModel
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            VStack (spacing: 0) {
                ZStack {
                    Image(category.image)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 220)
                        .clipped()

                    VStack {
                        Spacer()
                        ZStack {
                            Rectangle()
                                .foregroundColor(Color(UIColor.darkText))
//                                .foregroundColor(Color(UIColor.lightText))
                                .frame(height: 36)
                                .opacity(0.63)
                            
                            Text(category.name)
//                                .foregroundColor(Color(UIColor.darkText).opacity(0.9))
                                .foregroundColor(Color(UIColor.lightText))
                                .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize+4))
                                .fontWeight(.semibold)
                                .kerning(2.5) // Adjust the kerning value to your desired spacing

                        }
                    }
                    .frame(height: 220)

                }
                .frame(height: 220)

                
                HStack {
                    Text(category.description)
                        .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize-1))
                        .fontWeight(.light)
                        .padding(16)
                    Spacer()
                }
                
                Divider()
                
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(bookViewModel.books, id: \.id) { book in
                        if book.category.contains(category.name) {
                            VStack {
                                NavigationLink(destination: BookDetailView(userViewModel: userViewModel, bookViewModel: bookViewModel, reviewViewModel: reviewViewModel, currentBook: book)) {
                                    BookView(userViewModel: userViewModel, book: book)
                                }
                                Spacer()
                            }
                        }
                    }

                }
                .padding()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(category: testCategory, userViewModel: UserViewModel(), bookViewModel: BookViewModel(), reviewViewModel: ReviewViewModel())
    }
}
