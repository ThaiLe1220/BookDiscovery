//
//  CategoryCardView.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 19/09/2023.
//

import SwiftUI

struct CategoryCardView: View {
    @ObservedObject var userViewModel: UserViewModel
    @ObservedObject var bookViewModel: BookViewModel
    @ObservedObject var reviewViewModel: ReviewViewModel
    
    var category: Category

    var body: some View {
        ZStack {
            Image(category.image)
                .resizable()
                .clipShape(Path { path in
                    path.addRoundedRect(in: CGRect(x: 0, y: 0, width: 170, height: 110), cornerSize: CGSize(width: 10, height: 10))
                })
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 170, height: 110)
                .foregroundColor(.black)
                .opacity(0.3)

            VStack {
                Spacer ()
                HStack {
                    Text(category.name)
                        .foregroundColor(.white)
                        .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize-2))
                        .fontWeight(.semibold)
                        .padding(8)
                    Spacer()
                }
            }
        }
        .frame(width: 170, height: 110)

    }
}


struct CategoryCardView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCardView(userViewModel: UserViewModel(), bookViewModel: BookViewModel(), reviewViewModel: ReviewViewModel(), category: testCategory)
    }
}
