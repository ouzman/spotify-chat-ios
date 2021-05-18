//
//  DismissConversationEvent.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 18.05.2021.
//

import Foundation

struct DismissConversationEvent {
    let action: String // DismissConversation
    let data: DismissConversationEventData
    
    struct DismissConversationEventData {
        let conversation: String
    }
}
