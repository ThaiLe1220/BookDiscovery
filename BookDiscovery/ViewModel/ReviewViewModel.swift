//
//  ReviewViewModel.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 15/09/2023.
//

import Foundation

class ReviewViewModel: ObservableObject {
    @Published var currentUserReview: Review
    @Published var reviews: [Review] = []
    
    init(from: Review = emptyReview) {
        self.currentUserReview = from
    }
    
    func getReviews(bookID: String) {
        FireBaseDB().getAllReviews(bookID: bookID) { result in
            DispatchQueue.main.async {
                if let reviewData = result {
                    for reviewInfo in reviewData {
                        self.reviews.append(reviewInfo)
                    }
                }
            }
        }
    }
    
    
    func toDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        
        dictionary["id"] = self.currentUserReview.id
        dictionary["userID"] = self.currentUserReview.userID
        dictionary["bookID"] = self.currentUserReview.bookID
        dictionary["date"] = self.currentUserReview.date
        dictionary["rating"] = self.currentUserReview.rating
        dictionary["comment"] = self.currentUserReview.comment
        dictionary["likes"] = self.currentUserReview.likes
        dictionary["votedUserIds"] = self.currentUserReview.votedUserIds
        
        return dictionary
    }
    
    func getAvg() -> String {
        if reviews.count == 0 {
            return "0"
        }
        
        var average: Double = 0.0
        for review in reviews {
            average += Double(review.rating)
        }
        average /= Double(reviews.count)
        return String(format: "%.1f", average)
    }

}
