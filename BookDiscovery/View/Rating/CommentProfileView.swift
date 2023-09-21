//
//  CommentProfileView.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 13/09/2023.
//

import SwiftUI

struct CommentProfileView: View {
    var profileImage: UIImage
    
    var body: some View {
        VStack {
            Image(uiImage: profileImage)
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color(.black), lineWidth: 1)
                        .opacity(0.8)
                )
                .shadow(radius: 7)
        }
    }
}


struct CommentProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CommentProfileView(profileImage: UIImage(named: "profile")!)
    }
}
