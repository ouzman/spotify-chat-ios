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
        VStack(alignment: .center, spacing: nil, content: {
            Spacer()
            Button("chatListPage", action: {
                state.activeScene = .detail
            })
            Spacer()
        })
        .edgesIgnoringSafeArea(.all)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(trailing: LogoutButton())
    }
}

struct ConversationListView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationListView(viewModel: ConversationListViewModel())
    }
}
