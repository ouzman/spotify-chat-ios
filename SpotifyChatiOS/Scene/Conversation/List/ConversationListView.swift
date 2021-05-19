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
            
            Button(action: {
                viewModel.matchRequest()
            }) {
                Image(systemName: "music.quarternote.3")
                    .renderingMode(.template)
                    .foregroundColor(.white)
                    .padding()
                
                Text("Match")
                    .foregroundColor(.white)
                    .padding(.trailing, 40)
            }
            .background(Color.blue)
            .cornerRadius(25)
            .padding()
            .font(.system(size: 18, weight: .semibold, design: .rounded))
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