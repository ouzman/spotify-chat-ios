//
//  SendMessageEvent.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 18.05.2021.
//

import Foundation

struct SendMessageEvent {
    let action: String // SendMessage
    let data: SendMessageEventData
    
    struct SendMessageEventData {
        let conversation: String
        let message: Message
    }
    
    struct Message {
        let id: String
        let content: String
    }
}
