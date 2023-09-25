/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author/Group: 3 - Book Discovery
  Created  date: 13/09/2023
  Last modified: 25/09/2023
  Acknowledgement: N/A
*/

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
