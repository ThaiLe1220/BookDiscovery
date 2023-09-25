/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author/Group: 3 - Book Discovery
  Created  date: 14/09/2023
  Last modified: 25/09/2023
  Acknowledgement: N/A
*/

import SwiftUI

struct BookView: View {
    @ObservedObject var userViewModel: UserViewModel

    var book: Book
    var bookReviews: Int = 100
    
    var body: some View {
        VStack (spacing: 2.5) {
            Image(uiImage: book.image!)
                .resizable()
                .scaledToFit()
                .frame(width: 155, height: 199)
                .shadow(color: userViewModel.isOn ? .white.opacity(0.6) : .gray.opacity(0.4), radius: 2, x: 5, y: 5)

            
            Text(book.name)
                .font(.custom(userViewModel.selectedFont, size: userViewModel.selectedFontSize-1))
                .fontWeight(.regular)
                .lineLimit(2)
                .frame(height: 38)
                .glowBorder(color: .white, lineWidth: 4)
            RatingView(rating: book.rating)
                .frame(height: 12)
                .glowBorder(color: .white, lineWidth: 2)

        }
        .frame(width: 160, height: 235)
    }
}


struct BookView_Previews: PreviewProvider {
    static var previews: some View {
        BookView(userViewModel: UserViewModel(), book: testBook)
    }
}

struct GlowBorder: ViewModifier {
    var color: Color
    var lineWidth: Int
    
    func body(content: Content) -> some View {
        applyShadow(content: AnyView(content), lineWidth: lineWidth)
    }
    
    func applyShadow(content: AnyView, lineWidth: Int) -> AnyView {
        if lineWidth == 0 {
            return content
        } else {
            return applyShadow(content: AnyView(content.shadow(color: color, radius: 1)), lineWidth: lineWidth - 1)
        }
    }
}

extension View {
    func glowBorder(color: Color, lineWidth: Int) -> some View {
        self.modifier(GlowBorder(color: color, lineWidth: lineWidth))
    }
}
