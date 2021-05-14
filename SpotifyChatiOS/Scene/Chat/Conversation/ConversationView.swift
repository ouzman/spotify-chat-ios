//
//  ConversationView.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 13.05.2021.
//

import SwiftUI

struct ConversationView: View {
    @ObservedObject var viewModel: ConversationViewModel
    @EnvironmentObject var state: ChatViewState
    
    init(viewModel: ConversationViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: nil, content: {
            Spacer()
            Button("send message test", action: {
                viewModel.send(text: #"{"test": "misal"}"#)
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
        .navigationBarItems(leading: backButton,
                            trailing: LogoutButton())
    }
    
    var backButton: some View {
        Button(action: {
            state.activeScene = .chatList
        }) {
            Image(systemName: "chevron.backward")
                .renderingMode(.template)
                .foregroundColor(Color.blue)
        }
        .scaledToFill()
    }
}

struct Conversation_Previews: PreviewProvider {
    static var previews: some View {
        ConversationView(viewModel: ConversationViewModel())
    }
}
