//
//  NotificationsView.swift
//  BookDiscovery
//
//  Created by Thai, Le Hong on 14/09/2023.
//

import SwiftUI

struct NewsFeedView: View {
    @Binding var isOn: Bool

    @ObservedObject var userViewModel : UserViewModel
    @ObservedObject var bookViewModel: BookViewModel
    @ObservedObject var reviewViewModel: ReviewViewModel

    var body: some View {
        NavigationStack {
            VStack (spacing: 0) {
                NavigationBar(userViewModel: userViewModel)

                NavigationLink(destination: SettingView(isOn: $isOn, userViewModel: userViewModel), isActive: $userViewModel.showSettings) {
                    Text("").hidden()
                }
                .opacity(0)
                .frame(width: 0, height: 0)
                
                Divider()
                Spacer()
                
                List {
                    ForEach(reviewViewModel.allReviews, id: \.self) { review in
                        UserReviewView(isOn: $isOn, userViewModel: userViewModel, bookViewModel: bookViewModel, reviewViewModel: reviewViewModel, review: review)
                    }
                }
                .listStyle(.inset)
                
                Spacer()
                Divider()

            }
        }
    }
}

struct NewsFeedView_Previews: PreviewProvider {
    static var previews: some View {
        NewsFeedView(isOn: .constant(false), userViewModel: UserViewModel(), bookViewModel: BookViewModel(), reviewViewModel: ReviewViewModel())
    }
}
