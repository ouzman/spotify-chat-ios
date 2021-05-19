//
//  LogoutEvent.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 18.05.2021.
//

import Foundation

struct LogoutEvent: ClientEvent {
    let action: String // Logout
    let data: LogoutEventData
    
    struct LogoutEventData: Encodable {}
}
