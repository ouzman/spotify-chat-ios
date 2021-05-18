//
//  NewMessageEvent.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 15.05.2021.
//

import Foundation

struct NewMessageEvent: SocketEvent {
    let eventId: String
    let date: String
    let action: String
    let data: NewMessageEventData
    
    struct NewMessageEventData: Decodable {
        let conversationId: String
        let message: Conversation.Message
    }
}
