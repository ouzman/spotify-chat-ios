//
//  ClientEvent.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 18.05.2021.
//

import Foundation

protocol ClientEvent: Encodable {
    var action: String { get }
}
