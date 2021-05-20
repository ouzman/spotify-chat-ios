//
//  ConversationViewState.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 14.05.2021.
//

import Combine

enum ConversationScene {
    case list
    case detail
}

class ConversationViewState: ObservableObject {
    static let instance = ConversationViewState()
    @Published var isDetailActive = false
    
    @Published var activeConversation: Conversation? = nil
    @Published var activeScene: ConversationScene = .list {
        didSet {
            isDetailActive = activeScene == .detail
        }
    }
    @Published var activeStateTitle: String = ""

    private init() { }
}
