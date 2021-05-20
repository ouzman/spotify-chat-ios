//
//  ConversationMessageDataService.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 17.05.2021.
//

import Foundation

class ConversationMessageDataService: ObservableObject {
    static let instance = ConversationMessageDataService()
    
    let webSocketService = WebSocketService.instance
    @Published var conversationMessages = [String: [String: Conversation.Message]]()
        
    private init() {
        registerConversationMessageEventsConsumer()
    }
 
    private func registerConversationMessageEventsConsumer() {
        webSocketService.registerConsumer(
            messageType: "ConversationMessages",
            consumer: { (data: Data) in
                guard let event = try? JSONDecoder.getIsoDateConfiguredInstance().decode(ConversationMessageEvent.self, from: data) else {
                    return
                }
                self.addNewConversationMessage(conversationId: event.data.conversationId,
                                               messages: event.data.messages)
            }
        )

        webSocketService.registerConsumer(
            messageType: "NewMessage",
            consumer: { (data: Data) in
                guard let event = try? JSONDecoder.getIsoDateConfiguredInstance().decode(NewMessageEvent.self, from: data) else {
                    return
                }
                self.addNewConversationMessage(conversationId: event.data.conversationId,
                                               messages: [event.data.message])
            }
        )
    }
    
    private func addNewConversationMessage(conversationId: String, messages: [Conversation.Message]) {
        DispatchQueue.main.async {
            messages.forEach { message in
                if self.conversationMessages[conversationId] == nil {
                    self.conversationMessages[conversationId] = [:]
                }
                
                self.conversationMessages[conversationId]![message.id] = message
            }
        }
    }
        
}
