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
                ConversationListView(
                    viewModel: ConversationListViewModel()
                ).navigationBarHidden(true)
                
                NavigationLink(
                    destination: ConversationDetailView(viewModel: ConversationDetailViewModel()),
                    isActive: $state.isDetailActive,
                    label: {
                        EmptyView()
                    }).navigationBarHidden(true)
            }
        }
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

struct ConversationView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationView().environmentObject(ConversationViewState.instance)
    }
}
