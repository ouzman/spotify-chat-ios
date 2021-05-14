//
//  ReceivingChatMessage.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 14.05.2021.
//

import Foundation

struct ReceivingChatMessage: SocketMessage, Hashable {
    let type: String
    let date: Date
    let message: String
    let user: String
}
