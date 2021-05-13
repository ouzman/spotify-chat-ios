//
//  ChatList.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 13.05.2021.
//

import SwiftUI
import Combine

struct ChatList: View {
    @ObservedObject var viewModel: ChatListViewModel

    init(viewModel: ChatListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .navigationBarBackButtonHidden(true)
    }
}

struct ChatList_Previews: PreviewProvider {
    static var previews: some View {
        ChatList(viewModel: ChatListViewModel())
    }
}
