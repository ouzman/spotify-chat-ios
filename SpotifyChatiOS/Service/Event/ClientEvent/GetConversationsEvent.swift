//
//  GetConversationsEvent.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 18.05.2021.
//

import Foundation

struct GetConversationsEvent: ClientEvent {
    let action: String // GetConversations
    let data: GetConversationsEventData
    
    struct GetConversationsEventData: Encodable {}
}
