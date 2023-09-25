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
        "Le Hong Thai - s3752577",
        "Hua Nam Huy - s3881103",
        "Nguyen Giang Huy - s3836454",
        "Tran Hoang Vu - s3915185",
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
