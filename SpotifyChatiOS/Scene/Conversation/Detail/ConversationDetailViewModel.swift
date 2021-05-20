//
//  ConversationDetailViewModel.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 13.05.2021.
//

import Foundation
import Combine
import SwiftUI

class ConversationDetailViewModel: ObservableObject {
    private let service: WebSocketService = WebSocketService.instance
    private let conversationMessageDataService: ConversationMessageDataService = ConversationMessageDataService.instance
    private var cancellables = Set<AnyCancellable>()
    
    var conversation: Conversation?
    
    @Published var messages = [Conversation.Message]()
    
    init() {
        conversationMessageDataService.$conversationMessages
            .map { [weak self] conversationMessages in
                guard let self = self else {
                    return []
                }
                return Self.getMessagesOfConversation(conversationId: self.conversation?.id , messages: conversationMessages)
            }
            .sink { messages in
                self.messages = messages
            }
            .store(in: &cancellables)
    }
    
    func onAppear() {
        if let conversationId = conversation?.id {
            service.send(clientEvent: GetMessagesEvent(data: GetMessagesEvent.GetMessagesEventData(conversation: conversationId)))
        }
        self.messages = Self.getMessagesOfConversation(conversationId: self.conversation?.id,
                                                       messages: conversationMessageDataService.conversationMessages)
    }
    
    static func getMessagesOfConversation(conversationId: String?, messages: [String: [String: Conversation.Message]]) -> [Conversation.Message] {
        if let conversationId = conversationId,
            let messages = messages[conversationId] {
            return messages.values
                .sorted(by: { m1, m2 in
                    m1.date < m2.date
                })
        }
        
        return []
    }
    
    func sendMessage(text: String) {
        guard let conversationId = conversation?.id else { return }
        service.send(clientEvent: SendMessageEvent(data: SendMessageEvent.SendMessageEventData(conversation: conversationId,
                                                                                               message: SendMessageEvent.Message(id: "asd", content: text))))
    }
}
