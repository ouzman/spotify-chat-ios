//
//  ChatView.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 13.05.2021.
//

import SwiftUI

struct ChatView: View {
    @EnvironmentObject var state: ChatViewState
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Chat View")
                NavigationLink(destination: ChatListView(viewModel: ChatListViewModel()).environmentObject(state),
                               tag: ChatScene.chatList,
                               selection: Binding<ChatScene?>($state.activeScene)) {
                    EmptyView()
                }
                NavigationLink(destination: ConversationView(viewModel: ConversationViewModel()).environmentObject(state),
                               tag: ChatScene.conversation,
                               selection: Binding<ChatScene?>($state.activeScene)) {
                    EmptyView()
                }
            }
        }       
        .navigationBarHidden(true)
        .ignoresSafeArea()
        .onAppear(perform: {
            WebSocketService.instance.connect()
        })
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
