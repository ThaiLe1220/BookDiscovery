//
//  ChatCardView.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 22/09/2023.
//

import SwiftUI

struct ChatCardView: View {
    var username: String
    
    var body: some View {
        HStack {
            ZStack {
                Image(uiImage: UIImage(named: "profile")!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 75, height: 75)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color(.red), lineWidth: 2)
                            .opacity(0.8)
                    )
                    .shadow(radius: 7)
                Circle()
                    .fill(.red)
                    .frame(width: 17, height: 17)
                    .offset(x: 28, y: -28)
            }
            
            Text(username)
                .padding(.horizontal)
            Spacer()
        }
        .padding(.horizontal)
    }
}
