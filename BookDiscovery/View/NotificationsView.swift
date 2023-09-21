//
//  NotificationsView.swift
//  BookDiscovery
//
//  Created by Thai, Le Hong on 14/09/2023.
//

import SwiftUI

struct NotificationsView: View {
    @Binding var isOn: Bool

    @ObservedObject var userViewModel : UserViewModel
    @ObservedObject var bookViewModel: BookViewModel
    @ObservedObject var reviewViewModel: ReviewViewModel

    
    @State private var allReviews: [Review] = []
    
    var body: some View {
        NavigationStack {
            VStack {
//                NavigationBar(userViewModel: userViewModel)
                Text("Notifications View")
                Spacer()
                NavigationLink(destination: SettingView(isOn: $isOn, userViewModel: userViewModel), isActive: $userViewModel.showSettings) {
                    Text("").hidden()
                }
                .opacity(0)
                .frame(width: 0, height: 0)
                
                
            }
        }
        .onAppear {
            allReviews = []
            for book in bookViewModel.books {
                FireBaseDB().getAllReviews(bookID: book.id) { result in
                    DispatchQueue.main.async {
                        if let reviewData = result {
                            for reviewInfo in reviewData {
                                allReviews.append(reviewInfo)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView(isOn: .constant(false), userViewModel: UserViewModel(), bookViewModel: BookViewModel(), reviewViewModel: ReviewViewModel())
    }
}
