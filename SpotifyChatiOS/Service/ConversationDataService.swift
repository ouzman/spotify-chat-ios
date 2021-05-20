//
//  ConversationDataService.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 17.05.2021.
//

import Foundation

class ConversationDataService: ObservableObject {
    static let instance = ConversationDataService()
    
    let webSocketService = WebSocketService.instance
    @Published var conversations = [String: Conversation]()
        
    private init() {
        registerConversationEventsConsumer()
    }
 
    private func registerConversationEventsConsumer() {
        webSocketService.registerConsumer(
            messageType: "Conversations",
            consumer: { (data: Data) in
                guard let event = try? JSONDecoder.getIsoDateConfiguredInstance().decode(ConversationsEvent.self, from: data) else {
                    return
                }
                self.addNewConversations(conversations: event.data.conversations)
            }
        )

        webSocketService.registerConsumer(
            messageType: "NewConversation",
            consumer: { (data: Data) in
                do {
                    let event = try JSONDecoder.getIsoDateConfiguredInstance().decode(NewConversationEvent.self, from: data)
                    self.addNewConversations(conversations: [event.data.conversation])
                } catch(let error) {
                    print(error)
                }
            }
        )
    }
    
    private func addNewConversations(conversations: [Conversation]) {
        DispatchQueue.main.async {
            conversations.forEach { conversation in
                self.conversations[conversation.id] = conversation
            }
        }
    }
}
