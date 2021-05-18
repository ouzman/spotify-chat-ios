//
//  ConversationListView.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 13.05.2021.
//

import SwiftUI
import Combine

struct ConversationListView: View {
    @ObservedObject var viewModel: ConversationListViewModel
    @EnvironmentObject var state: ConversationViewState
    
    init(viewModel: ConversationListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack() {
            ScrollView() {
                LazyVStack(alignment: .leading, spacing: 25) {
                    ForEach(viewModel.conversations, id: \.id) { conversation in
                        
                        Button(action: {
                            state.activeConversation = conversation
                            state.activeScene = .detail
                        }) {
                            ConversationListRow(conversation: conversation)
                        }
                    }
                    .padding(10)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(trailing: LogoutButton())
        .navigationTitle("Chats")
    }
}

struct ConversationListView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationListView(viewModel: ConversationListViewModel())
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
