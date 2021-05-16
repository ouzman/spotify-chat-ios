//
//  ConversationListViewModel.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 13.05.2021.
//

import Foundation

class ConversationListViewModel: ObservableObject {
    @Published private(set) var conversations: [Conversation] = [
        Conversation(id: UUID(),
                     userImage: "",
                     messages: [ConversationMessage(id: UUID(),
                                                       type: "",
                                                       date: "01-01-2021 12:16",
                                                       message: "message content",
                                                       userName: "John Doe",
                                                       isLoggedInUser: true)]),
        Conversation(id: UUID(),
                     userImage: "",
                     messages: [ConversationMessage(id: UUID(),
                                                       type: "",
                                                       date: "02-01-2021 12:16",
                                                       message: "Message dummy",
                                                       userName: "Jane Doe",
                                                       isLoggedInUser: true)])
    ]
}
