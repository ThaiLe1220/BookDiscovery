//
//  Message.swift
//  BookDiscovery
//
//  Created by Loc Phan Vinh on 22/09/2023.
//

import Foundation

struct Message: Codable, Equatable {
    var id: String
    var sender: String
    var receiver: String
    var date: String
    var content: String
}

let user1: String = "fEInlVUwLnbH1CJfQpWVChGo6VB3"
let user2: String = "jZyLaM4hAwQXH5GwiJK7Odw0Jop1"

let emptyMessage: Message = Message(
    id: "",
    sender: "",
    receiver: "",
    date: "",
    content: ""
)


let message_1: Message = Message(
    id: "1",
    sender: "A",
    receiver: "B",
    date: "",
    content: "Message 1"
)

let message_2: Message = Message(
    id: "2",
    sender: "B",
    receiver: "A",
    date: "",
    content: "Message 2"
)

let message_long_1: Message = Message(
    id: "3",
    sender: "B",
    receiver: "A",
    date: "",
    content: "Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long"
)

let message_long_2: Message = Message(
    id: "4",
    sender: "A",
    receiver: "C",
    date: "",
    content: "Message Long Message Long Message Long Message Long Message Long Message Long Message Long Message Long"
)
