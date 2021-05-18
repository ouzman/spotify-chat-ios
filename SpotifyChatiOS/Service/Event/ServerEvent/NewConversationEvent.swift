//
//  NewConversationEvent.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 15.05.2021.
//

import Foundation

struct NewConversationEvent: SocketEvent {
    let eventId: String
    let date: String
    let action: String
    let data: ConversationEventData
    
    struct ConversationEventData: Decodable {
        let conversation: Conversation
    }
}
