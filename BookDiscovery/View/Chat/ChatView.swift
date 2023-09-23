//
//  ChatView.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 22/09/2023.
//

import SwiftUI

struct ChatView: View {
    @StateObject var messageViewModel: MessageViewModel
    var receiver: String
    
    @State var content: String = ""
    
    var body: some View {
        ZStack {
            Color(.gray)
                .opacity(0.2)
                .edgesIgnoringSafeArea(.all)
            VStack {
                ScrollViewReader { proxy in
                    VStack {
                        ForEach(messageViewModel.chatMessages, id: \.id) { message in
                            switch message.sender {
                            case receiver:
                                HStack {
                                    ChatBubbleView(message: message.content, isLeft: false)
                                        .id(message.id)

                                    Spacer()
                                }
                                .padding(.horizontal)
                            default:
                                HStack {
                                    Spacer()
                                    ChatBubbleView(message: message.content, isLeft: true)
                                        .id(message.id)

                                }
                                .padding(.horizontal)
                            }
                        }
                        .onAppear {
                            messageViewModel.getMessagesWith(otherUserID: receiver)
                        }
                        .onChange(of: messageViewModel.messages) { _ in
                            messageViewModel.getMessagesWith(otherUserID: receiver)
                        }
                    }
                }
                
                HStack {
                    TextEditor(text: $content)
                        .fontWeight(.regular)
                        .frame(minHeight: 40)
                        .frame(height: 40)
                        .border(.gray, width: 1)
                    Button {
                        messageViewModel.sendMessageTo(receiverID: receiver, message: content)
                        content = ""
                    } label: {
                        Image(systemName: "paperplane.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                    }
                    
                }
                .padding(.horizontal)
            }
        }
        .onAppear {
            messageViewModel.getMessagesWith(otherUserID: receiver)
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(messageViewModel: MessageViewModel(userID: "-1"), receiver: "2")
    }
}
