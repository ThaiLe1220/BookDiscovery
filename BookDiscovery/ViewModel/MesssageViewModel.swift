//
//  MessageViewModel.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 22/09/2023.
//

import Foundation
import FirebaseFirestore

class MessageViewModel: ObservableObject {
    @Published var senderID: String = ""
    @Published var messages: [Message] = []
    @Published var chatMessages: [Message] = []
    @Published var listOfUsers: [String: String] = [:]
    
    init(userID: String) {
        senderID = userID
        getAllMessagesFrom()
    }
    
    func getAllMessagesFrom() {
        FireBaseDB().getAllMessagesFrom(userID: senderID) { messages in
            DispatchQueue.main.async {
                if let messages = messages {
                    self.messages = messages
                    self.getListOfUsers()

                }
            }
        }
        
    }
    
    func getMessagesWith(otherUserID: String) {
        chatMessages = []
        for message in messages {
            if message.sender == otherUserID || message.receiver == otherUserID {
                chatMessages.append(message)
            }
        }
        
        chatMessages.sort { (message1, message2) -> Bool in
                return message1.date < message2.date
        }
    }
    
    func sendMessageTo(receiverID: String, message: String) {
        var formattedDateForID: String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyyMMddhhmmss"
            return dateFormatter.string(from: Date())
        }
        
        var formattedDateTime: String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
            return dateFormatter.string(from: Date())
        }
        
        var newMessage: Message = emptyMessage
        newMessage.id = "\(formattedDateForID)_\(senderID)_\(receiverID)"
        newMessage.sender = senderID
        newMessage.receiver = receiverID
        newMessage.date = formattedDateTime
        newMessage.content = message

        
        FireBaseDB().addMessage(message: newMessage) { success in
            if success! {
                self.messages.append(newMessage)
            } else {
                print("Error when sending message")
            }
        }
    }
    
    func getListOfUsers() {
        for message in messages {
            if message.sender != senderID {
                if !self.listOfUsers.keys.contains(message.sender) {
                    FireBaseDB().fetchUsername(userID: message.sender) { username in
                            self.listOfUsers[message.sender] = username
                    }
                }
            } else if message.receiver != senderID {
                if !self.listOfUsers.keys.contains(message.receiver) {
                    FireBaseDB().fetchUsername(userID: message.receiver) { username in
                            self.listOfUsers[message.receiver] = username
                    }
                }
            }
        }
    }
}
