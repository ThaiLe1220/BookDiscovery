/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author/Group: 3 - Book Discovery
  Created  date: 14/09/2023
  Last modified: 25/09/2023
  Acknowledgement: N/A
*/

import SwiftUI

struct NewsFeedView: View {
    @ObservedObject var userViewModel : UserViewModel
    @ObservedObject var bookViewModel: BookViewModel
    @ObservedObject var reviewViewModel: ReviewViewModel

    var body: some View {
        NavigationView {
            VStack (spacing: 0) {
                HeaderView(userViewModel: userViewModel, tabName: "Review")
                
                Divider()
                    .padding(.vertical, 10)
                HStack {
                    Text("All Reviews")
                        .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize))
                        .foregroundColor(userViewModel.isOn ? .white : .black)
                        .fontWeight(.semibold)
                        .padding(.horizontal)

                    Spacer()
                }
                .padding(.bottom)

                List {
                    ForEach(reviewViewModel.allReviews, id: \.self) { review in
                        UserReviewView(userViewModel: userViewModel, bookViewModel: bookViewModel, reviewViewModel: reviewViewModel, review: review)
                    }
                }
                .listStyle(.plain)
                
                Divider()

            }
        }
    }
}

struct NewsFeedView_Previews: PreviewProvider {
    static var previews: some View {
        NewsFeedView(userViewModel: UserViewModel(), bookViewModel: BookViewModel(), reviewViewModel: ReviewViewModel())
    }
}
