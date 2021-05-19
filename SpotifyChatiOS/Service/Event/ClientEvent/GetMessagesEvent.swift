//
//  GetMessagesEvent.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 18.05.2021.
//

import Foundation

struct GetMessagesEvent: ClientEvent {
    let action: String // GetMessages
    let data: GetMessagesEventData
    
    struct GetMessagesEventData: Encodable {
        let conversation: String
    }
}
