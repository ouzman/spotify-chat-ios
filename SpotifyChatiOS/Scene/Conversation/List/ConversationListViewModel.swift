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
    @Published var loading = false

    init() {
        conversationDataService.$conversations
            .sink { conversationDict in
                return self.conversations = conversationDict.values
                    .sorted { c1, c2 in
                        c1.date > c2.date
                    }
            }
            .store(in: &cancellables)
        
        
        service.registerConsumer(
            messageType: "NewConversation",
            consumer: { [weak self] (data: Data) in
                guard let event = try? JSONDecoder.getIsoDateConfiguredInstance().decode(NewConversationEvent.self, from: data) else {
                    return
                }
                
                self?.loading = false
                ConversationViewState.instance.activeConversation = event.data.conversation
                ConversationViewState.instance.activeScene = .detail
            }
        )
    }
    
    func onAppear() {
        service.send(clientEvent: GetConversationsEvent(data: GetConversationsEvent.GetConversationsEventData()))
    }
    
    func matchRequest() {
        service.send(clientEvent: MatchRequestEvent(data: MatchRequestEvent.MatchRequestEventData()))
    }
}
