//
//  SendMessageEvent.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 18.05.2021.
//

import Foundation

struct SendMessageEvent: ClientEvent {
    let action = "SendMessage"
    let service = "Conversation"
    let data: SendMessageEventData
    
    struct SendMessageEventData: Encodable {
        let conversation: String
        let message: Message
    }
    
    struct Message: Encodable {
        let id: String
        let content: String
    }
}
