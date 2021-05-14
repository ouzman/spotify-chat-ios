//
//  ChatListView.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 13.05.2021.
//

import SwiftUI
import Combine

struct ChatListView: View {
    @ObservedObject var viewModel: ChatListViewModel
    @EnvironmentObject var state: ChatViewState

    init(viewModel: ChatListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: nil, content: {
            Spacer()
            Button("chatListPage", action: {
                state.activeScene = .conversation
            })
                .frame(minWidth: 0,
                       idealWidth: .infinity,
                       maxWidth: .infinity,
                       maxHeight: 40,
                       alignment: .center)
                .padding(.all)
                .padding(.bottom, 20)
            Spacer()
        })
        .edgesIgnoringSafeArea(.all)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(trailing: LogoutButton())
    }
}

struct ChatList_Previews: PreviewProvider {
    static var previews: some View {
        ChatListView(viewModel: ChatListViewModel())
    }
}
