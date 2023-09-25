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

struct RatingView: View {// RatingView struct is responsible for rendering a 5-star rating UI

    var rating: Double    // The actual rating to be displayed

    
    var body: some View {    // Main View body

        HStack (spacing: 3) {        // Horizontal Stack to hold the star images

            ForEach(0..<5) { index in            // Loop through 5 times to generate each star

                Image(systemName: calculateStarName(for: index))                // Use image name calculated by the function calculateStarName()

                    .foregroundColor(calculateStarColor(for: index))                    // Use color calculated by the function calculateStarColor()

                    .font(.system(size: 17))                    // Set the font size for the star

            }
        }
    }
    
    private func calculateStarName(for index: Int) -> String {    // Function to calculate the name of the star (full, half, or empty)
        let remainder = rating - Double(index)        // Calculate how much of this star should be filled

        if remainder >= 1 {        // Determine the star image to display

            return "star.fill"
        } else if remainder >= 0.5 {
            return "star.leadinghalf.fill"
        } else {
            return "star"
        }
    }
    
    private func calculateStarColor(for index: Int) -> Color {    // Function to calculate the color of the star (yellow for filled, gray for empty)

        let remainder = rating - Double(index)        // Calculate how much of this star should be filled

        if remainder >= 0.5 {        // Determine the star color

            return .yellow
        } else {
            return .gray
        }
    }
}
// Preview for the RatingView
struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: 2.5)
    }
}
