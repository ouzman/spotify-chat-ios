//
//  Conversation.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 13.05.2021.
//

import SwiftUI

struct Conversation: View {
    @ObservedObject var viewModel: ConversationViewModel
    
    init(viewModel: ConversationViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct Conversation_Previews: PreviewProvider {
    static var previews: some View {
        Conversation(viewModel: ConversationViewModel())
    }
}
