//
//  RatingView.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 13/09/2023.
//

import SwiftUI

struct RatingView: View {
    var rating: Double
    
    var body: some View {
        HStack (spacing: 3) {
            ForEach(0..<5) { index in
                Image(systemName: calculateStarName(for: index))
                    .foregroundColor(calculateStarColor(for: index))
                    .font(.system(size: 17))
            }
        }
    }
    
    private func calculateStarName(for index: Int) -> String {
        let remainder = rating - Double(index)
        if remainder >= 1 {
            return "star.fill"
        } else if remainder >= 0.5 {
            return "star.leadinghalf.fill"
        } else {
            return "star"
        }
    }
    
    private func calculateStarColor(for index: Int) -> Color {
        let remainder = rating - Double(index)
        if remainder >= 0.5 {
            return .yellow
        } else {
            return .gray
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: 2.5)
    }
}
