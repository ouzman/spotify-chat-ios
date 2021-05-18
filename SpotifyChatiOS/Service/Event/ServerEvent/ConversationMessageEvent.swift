//
//  ConversationMessageEvent.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 14.05.2021.
//

import Foundation

struct ConversationMessageEvent: SocketEvent {
    let eventId: String
    let date: String
    let action: String
    let data: ConversationMessageEventData
    
    struct ConversationMessageEventData: Decodable {
        let conversationId: String
        let messages: [Conversation.Message]
    }
}
