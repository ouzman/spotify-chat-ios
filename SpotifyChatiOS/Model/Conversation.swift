//
//  Conversation.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 17.05.2021.
//

import Foundation

struct Conversation: Decodable {
    let id: String
    let date: Date
    let lastMessage: Message?
    let song: Song
    let users: [String: User]
    
    enum CodingKeys: String, CodingKey {
        case id, date, lastMessage, song, users
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try values.decode(String.self, forKey: .id)
        self.date = try values.decode(Date.self, forKey: .date)
        self.lastMessage = try values.decodeIfPresent(Message.self, forKey: .lastMessage)
        self.song = try values.decode(Song.self, forKey: .song)
        let originalUsers = try values.decode([User].self, forKey: .users)
        self.users = Dictionary(uniqueKeysWithValues: originalUsers.map{ ($0.id, $0) })
    }
    
    init(id: String, date: Date, lastMessage: Message, song: Song, users: [String: User]) {
        self.id = id
        self.lastMessage = lastMessage
        self.date = date
        self.song = song
        self.users = users
    }
    
    struct Message: Decodable, Hashable {
        let id: String
        let actorId: String
        let content: String
        let date: Date
        
        func fromLoggedInUser() -> Bool {
            self.id == MainViewState.instance.userId
        }
    }

    struct Song: Decodable {
        let id: String
        let name: String
        let artist: String
        let image: String?
    }

    struct User: Decodable {
        let id: String
        let name: String
        let profilePhotoUrl: String?
    }
}

