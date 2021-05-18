//
//  SocketEvent.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 14.05.2021.
//

protocol SocketEvent: Decodable {
    var action: String { get }
}
