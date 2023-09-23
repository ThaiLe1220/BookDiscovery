//
//  ChatBubbleView.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 22/09/2023.
//

import SwiftUI

struct ChatBubbleView: View {
    var message: String
    var isLeft: Bool
    
    var body: some View {
        Text(message)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .foregroundColor(isLeft ? .black : .white)
            .background(isLeft ? .gray.opacity(0.35) : .red.opacity(0.8))
            .cornerRadius(12)
    }
}

struct ChatBubbleView_Previews: PreviewProvider {
    static var previews: some View {
        ChatBubbleView(message: "Hello", isLeft: true)
    }
}
