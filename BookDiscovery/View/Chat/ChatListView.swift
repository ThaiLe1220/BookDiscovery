//
//  ChatListView.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 22/09/2023.
//

import SwiftUI

struct ChatListView: View {
    @ObservedObject var messageViewModel: MessageViewModel
    
    var body: some View {
        ScrollView {
            ForEach(Array(messageViewModel.listOfUsers.keys), id: \.self) { userID in
                NavigationLink(destination: ChatView(messageViewModel: messageViewModel, receiver: userID)) {
                    ChatCardView(username: messageViewModel.listOfUsers[userID]!)
                }
            }
        }
    }
}


struct ChatListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatListView(messageViewModel: MessageViewModel(userID: "-1"))
    }
}
