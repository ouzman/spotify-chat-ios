//
//  ChatView.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 13.05.2021.
//

import SwiftUI

struct ChatView: View {
    @EnvironmentObject var state: AppState
    
    var body: some View {
        VStack {
            Text("Mobile File Sharing App")
            NavigationLink(destination: ChatList(viewModel: ChatListViewModel()),
                           tag: ActiveScene.chatList,
                           selection: Binding<ActiveScene?>($state.activeScene)) {
                EmptyView()
            }
            NavigationLink(destination: Conversation(viewModel: ConversationViewModel()),
                           tag: ActiveScene.conversation,
                           selection: Binding<ActiveScene?>($state.activeScene)) {
                EmptyView()
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
        .ignoresSafeArea()
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
