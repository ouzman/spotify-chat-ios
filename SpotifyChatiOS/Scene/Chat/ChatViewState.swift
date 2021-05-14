//
//  ChatViewState.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 14.05.2021.
//

import Combine

enum ChatScene {
    case chatList
    case conversation
}

class ChatViewState: ObservableObject {
    static let instance = ChatViewState()
    @Published var activeConversation: String? = nil
    @Published var activeScene: ChatScene = .chatList
    
    private init() { }
}
