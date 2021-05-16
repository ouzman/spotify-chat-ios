//
//  ConversationView.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 13.05.2021.
//

import SwiftUI

struct ConversationView: View {
    @EnvironmentObject var state: ConversationViewState
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Chat View")
                NavigationLink(
                    destination: ConversationListView(
                        viewModel: ConversationListViewModel()
                    )
                    .environmentObject(state),
                    tag: ConversationScene.list,
                    selection: Binding<ConversationScene?>($state.activeScene)) {
                    EmptyView()
                }
                NavigationLink(
                    destination: ConversationDetailView(
                        viewModel: ConversationDetailViewModel()
                    )
                    .environmentObject(state),
                    tag: ConversationScene.detail,
                    selection: Binding<ConversationScene?>($state.activeScene)) {
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

struct ConversationView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationView().environmentObject(ConversationViewState.instance)
    }
}
