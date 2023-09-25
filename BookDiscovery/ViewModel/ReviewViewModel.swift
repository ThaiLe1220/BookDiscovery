/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author/Group: 3 - Book Discovery
  Created  date: 15/09/2023
  Last modified: 25/09/2023
  Acknowledgement: N/A
*/

import Foundation

class ReviewViewModel: ObservableObject {
    @Published var currentUserReview: Review
    @Published var currentBookReviews: [Review] = []
    @Published var allReviews: [Review] = []

    init() {
        self.currentUserReview = emptyReview
        initAllReviews()
    }
    
    func getReviewsByBook(bookID: String) {
        self.currentBookReviews = allReviews.filter { $0.bookID == bookID }
    }
    
    func initAllReviews() {
        FireBaseDB().getAllReviews() { result in
            DispatchQueue.main.async {
                if let reviewData = result {
                    self.allReviews = reviewData
                }
            }
        }
    }
    
    func getAvg() -> String {
        if currentBookReviews.count == 0 {
            return "0"
        }
        
        var average: Double = 0.0
        for review in currentBookReviews {
            average += Double(review.rating)
        }
        average /= Double(currentBookReviews.count)
        return String(format: "%.1f", average)
    }

}
