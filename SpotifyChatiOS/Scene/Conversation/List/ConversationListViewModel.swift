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
    private let conversationMessageDataService = ConversationMessageDataService.instance
    private var cancellables = Set<AnyCancellable>()
    
    @Published var conversations = [Conversation]()
    @Published var conversationRowModels = [String:ConversationListRowModel]()
    @Published var loading = false

    init() {
        conversationDataService.$conversations
            .map({ (conversations) -> [Conversation] in
                return conversations.values
                    .sorted { c1, c2 in
                        c1.date > c2.date
                    }
            })
            .assign(to: \.conversations, on: self)
            .store(in: &cancellables)
        
        Publishers.CombineLatest(self.$conversations, conversationMessageDataService.$conversationMessages)
            .map { (conversations: [Conversation], messages: [String:[String:Conversation.Message]]) -> [String:ConversationListRowModel] in
                return conversations.reduce(into: [:]) { (acc, conversation) in
                    let model = self.getConversationListRowModel(conversation: conversation, conversationMesasges: messages[conversation.id])
                    acc[conversation.id] = model
                }
            }
            .assign(to: \.conversationRowModels, on: self)
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
        WebSocketService.instance.connect()
        service.send(clientEvent: GetConversationsEvent(data: GetConversationsEvent.GetConversationsEventData()))
    }
    
    func matchRequest() {
        service.send(clientEvent: MatchRequestEvent(data: MatchRequestEvent.MatchRequestEventData()))
    }
    
    func getConversationListRowModel(conversation: Conversation, conversationMesasges: [String:Conversation.Message]?) -> ConversationListRowModel {
        let lastMessage = conversationMesasges?.values
            .sorted(by: { $0.date.compare($1.date) == .orderedDescending })
            .first ?? conversation.lastMessage
        
        var lastMessageActorName: String? = nil
        if let lastMessage = lastMessage {
            lastMessageActorName = conversation.users[lastMessage.actorId]?.name
        }
        
        return ConversationListRowModel(artistName: conversation.song.artist,
                                        songName: conversation.song.name,
                                        songImage: conversation.song.image,
                                        lastMessageActorName: lastMessageActorName,
                                        lastMessageContent:lastMessage?.content,
                                        lastUpdatedDate: lastMessage?.date ?? conversation.date)
    }
}
