//
//  SocketMessage.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 14.05.2021.
//

protocol SocketMessage: Codable {
    var type: String { get }
}
