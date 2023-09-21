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

    @State private var allReviews: [Review] = []
    
    var body: some View {
        NavigationStack {
            VStack {
//                NavigationBar(userViewModel: userViewModel)
                Spacer()
                NavigationLink(destination: SettingView(isOn: $isOn, userViewModel: userViewModel), isActive: $userViewModel.showSettings) {
                    Text("").hidden()
                }
                .opacity(0)
                .frame(width: 0, height: 0)
                
                List {
                    ForEach(allReviews, id: \.self) { review in
                        VStack {
                            HStack{
                                CommentView(isOn: $isOn, review: review, userViewModel: userViewModel)
                                    .onAppear {
                                        allReviews.sort(by: {$0.date > $1.date})
                                    }
                            }
                            HStack {
                                ForEach(bookViewModel.books, id: \.self) { book in
                                    if (book.id == review.bookID) {

                                            NavigationLink(destination: BookDetailView(isOn: $isOn, userViewModel: userViewModel, bookViewModel: bookViewModel, currentBook: book)) {
                                                HStack {
                                                    VStack {
                                                        Image(uiImage: book.image!)
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: 50, height: 64)
                                                    }
                                                    Spacer()
                                                    VStack {
                                                        Text(book.name)
                                                        Text(book.author.name)
                                                    }

                                                    Spacer()
                                                }
                                                
                                            }
                                    }
                                }
                            }
                            .padding()
                            .background{
                                Rectangle()
                                    .fill(Color(UIColor.secondarySystemBackground))
                                    .cornerRadius(20)
                            }
                        }
                        .background{
                            Rectangle()
                                .fill(Color(UIColor.systemBackground))
                                .cornerRadius(20)
                        }
                    }
                }
                .listStyle(.inset)
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

struct NewsFeedView_Previews: PreviewProvider {
    static var previews: some View {
        NewsFeedView(isOn: .constant(false), userViewModel: UserViewModel(), bookViewModel: BookViewModel(), reviewViewModel: ReviewViewModel())
    }
}
