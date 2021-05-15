//
//  ConversationViewModel.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 13.05.2021.
//

import Foundation
import Combine
import SwiftUI

class ConversationViewModel: ObservableObject {
    private let service: WebSocketService = WebSocketService.instance
    @Published private(set) var messages: [ReceivingChatMessage] = []
    
    init() {
        service.registerConsumer(
            messageType: "NEW_CHAT_MESSAGE",
            consumer: { (data: Data) in
                guard var message = try? JSONDecoder().decode(ReceivingChatMessage.self, from: data) else {
                    return
                }
                message.id = UUID() // TODO remove after backend integration
                print(message)
                self.messages.append(message)
            }
        )
    }
    
    func send(text: String) {
        service.send(text: text)
    }
}
