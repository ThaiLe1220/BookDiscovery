//
//  NotificationsView.swift
//  BookDiscovery
//
//  Created by Thai, Le Hong on 14/09/2023.
//

import SwiftUI

struct NewsFeedView: View {
    @ObservedObject var userViewModel : UserViewModel
    @ObservedObject var bookViewModel: BookViewModel
    @ObservedObject var reviewViewModel: ReviewViewModel

    var body: some View {
        NavigationView {
            VStack (spacing: 0) {
                HeaderView(userViewModel: userViewModel, tabName: "Review")
                
//                NavigationBar(userViewModel: userViewModel)
//                    .padding(.top, 8)
//                    .padding(.bottom, 16)
//
//                NavigationLink(destination: SettingView(userViewModel: userViewModel), isActive: $userViewModel.showSettings) {
//                    Text("").hidden()
//                }
//                .opacity(0)
//                .frame(width: 0, height: 0)
                
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
