//
//  ConversationMessage.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 14.05.2021.
//

import Foundation

struct ConversationMessage: SocketMessage, Hashable, Identifiable {
    var id: UUID?
    let type: String
    let date: String
    let message: String
    let userName: String
    let isLoggedInUser: Bool
}
