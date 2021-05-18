//
//  ConversationListViewModel.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 13.05.2021.
//

import Combine

class ConversationListViewModel: ObservableObject {
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
    }
}
