//
//  ConversationListRow.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 15.05.2021.
//

import SwiftUI

struct ConversationListRow: View {
    let message: Conversation

    var body: some View {
        HStack {

            //TODO image
            
            
            VStack(alignment: .leading) {
                Text(message.conversation.userName)
                    .fontWeight(.bold)
                    .font(.system(size: 16))
                
                Text(message.conversation.message)
                    .font(.system(size: 16))
            }
        }
    }
}

struct ConversationListRow_Previews: PreviewProvider {
    static var previews: some View {
        ConversationListRow(message: Conversation(
                                userImage: "",
                                conversation: ConversationMessage(
                                    type: "NEW_CHAT_MESSAGE",
                                    date: "01-01-2021 12:16",
                                    message: "message from user1",
                                    userName: "user1",
                                    isLoggedInUser: true)))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
