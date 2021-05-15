//
//  Conversation.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 15.05.2021.
//

import Foundation

struct Conversation: Decodable {
    let userImage: String
    let conversation: ConversationMessage
}
