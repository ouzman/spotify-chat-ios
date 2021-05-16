//
//  ConversationListRow.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 15.05.2021.
//

import SwiftUI
import Combine

struct ConversationListRow: View {
    let conversation: Conversation
    
    var body: some View {
        HStack {
            // TODO update url
            RemoteImage(url: "https://i.scdn.co/image/ab67616d0000b273da5658301db50de20d4d6106")
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .shadow(radius: 10)
                                
            VStack(alignment: .leading) {
                if let lastMessage = conversation.messages.last {
                    Text("Khruangbin - Master Of Life")
                        .font(.system(size: 15))
                        .lineLimit(1)
                        .padding(.bottom, 1)
                    
                    Text("\(lastMessage.userName): \(lastMessage.message)")
                        .italic()
                        .font(.system(size: 12))
                        .lineLimit(1)
                }
            }
        }
    }
}

struct ConversationListRow_Previews: PreviewProvider {
    static var previews: some View {
        ConversationListRow(
            conversation: Conversation(
                id: UUID(),
                userImage: "",
                messages: [ConversationMessage(
                            type: "NEW_CHAT_MESSAGE",
                            date: "01-01-2021 12:16",
                            message: "message from user1",
                            userName: "user1",
                            isLoggedInUser: true)]))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
