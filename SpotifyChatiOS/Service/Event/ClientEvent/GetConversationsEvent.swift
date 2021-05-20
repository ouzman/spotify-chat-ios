//
//  GetConversationsEvent.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 18.05.2021.
//

import Foundation

struct GetConversationsEvent: ClientEvent {
    let action = "GetConversations"
    let service = "Conversation"
    let data: GetConversationsEventData
    
    struct GetConversationsEventData: Encodable {}
}
