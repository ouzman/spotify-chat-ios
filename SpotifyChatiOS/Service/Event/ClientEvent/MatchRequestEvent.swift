//
//  MatchRequestEvent.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 18.05.2021.
//

import Foundation

struct MatchRequestEvent: ClientEvent {
    let action: String
    let data: MatchRequestEventData
    
    struct MatchRequestEventData: Encodable {}
}
