//
//  Conversation.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 15.05.2021.
//

import Foundation

struct Conversation: Decodable, Identifiable {
    var id: UUID? //Update it
    let userImage: String
    let messages: [ConversationMessage]
}
