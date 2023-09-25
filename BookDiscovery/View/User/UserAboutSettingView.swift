/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author/Group: 3 - Book Discovery
  Created  date: 25/09/2023
  Last modified: 25/09/2023
  Acknowledgement: N/A
*/

import SwiftUI

struct UserAboutSettingView: View {
    let authors = [
        "Le Hong Thai - s",
        "Hua Nam Huy - s",
        "Nguyen Giang Huy - s",
        "Tran Hoang Vu - s",
        "Phan Vinh Loc - s3938497"
    ]
    
    var body: some View {
        VStack {
            HStack {
                Text("Authors:")
                    .bold()
                Spacer()
            }
            .padding(.horizontal, 20)
            
            ForEach(authors, id: \.self) { author in
                HStack {
                    Text(author)
                    Spacer()
                }
                .padding(.horizontal, 40)
            }
        
            Spacer()
        }
    }
}

struct UserAboutSettingView_Previews: PreviewProvider {
    static var previews: some View {
        UserAboutSettingView()
    }
}
