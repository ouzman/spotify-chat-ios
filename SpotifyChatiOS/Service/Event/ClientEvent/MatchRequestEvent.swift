//
//  MatchRequestEvent.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 18.05.2021.
//

import Foundation

struct MatchRequestEvent {
    let action: String // MatchRequest
    let data: MatchRequestEventData
    
    struct MatchRequestEventData {}
}
