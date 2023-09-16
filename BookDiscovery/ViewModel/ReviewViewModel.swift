//
//  ReviewViewModel.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 15/09/2023.
//

import Foundation

class ReviewViewModel: ObservableObject {
    @Published var reviews: [Review] = []
    
    init(from: [Review] = []) {        
        self.reviews.append(testReview2)
    }
    
    func getReviews(from: Book) {
        
    }
}
