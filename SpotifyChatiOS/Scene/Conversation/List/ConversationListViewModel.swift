//
//  ConversationListViewModel.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 13.05.2021.
//

import Foundation
import Combine

class ConversationListViewModel: ObservableObject {
    private let service: WebSocketService = WebSocketService.instance
    private let conversationDataService = ConversationDataService.instance
    private var cancellables = Set<AnyCancellable>()
    
    @Published var conversations = [Conversation]()
    
    init() {
        conversationDataService.$conversations
            .sink { conversationDict in
                return self.conversations = conversationDict.values
                    .sorted { c1, c2 in
                        c1.lastMessage.date > c2.lastMessage.date
                    }
            }
            .store(in: &cancellables)
        
        
        service.registerConsumer(
            messageType: "NewConversation",
            consumer: { (data: Data) in
                guard let event = try? JSONDecoder().decode(NewConversationEvent.self, from: data) else {
                    return
                }
                
                ConversationViewState.instance.activeConversation = event.data.conversation
                ConversationViewState.instance.activeScene = .detail
            }
        )
    }
    
    func matchRequest() {
        service.send(clientEvent: MatchRequestEvent(action: "MatchRequest",
                                                    data: MatchRequestEvent.MatchRequestEventData()))
    }
}
