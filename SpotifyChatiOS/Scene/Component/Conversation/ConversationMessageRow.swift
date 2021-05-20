//
//  ConversationMessageRow.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 15.05.2021.
//

import SwiftUI

struct ConversationMessageRow: View {
    let users: [String:Conversation.User]
    let message: Conversation.Message
    
    private var isMyMessage: Bool {
        return self.message.actorId == MainViewState.instance.userId
    }
    
    
    var body: some View {
        HStack {
            if isMyMessage {
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(self.users[message.actorId]?.name ?? "")
                        .fontWeight(.bold)
                        .font(.system(size: 12))
                    
                    Text(message.date.getTime())
                        .font(.system(size: 10))
                        .opacity(0.7)
                }
                
                Text(message.content)
            }
            .foregroundColor(isMyMessage ? .white : .black)
            .padding(10)
            .background(isMyMessage ? Color.blue : Color(white: 0.95))
            .cornerRadius(5)
            
            if !isMyMessage {
                Spacer()
            }
        }
        .transition(.scale(scale: 0, anchor: isMyMessage ? .topTrailing : .topLeading))
    }
}

struct ConversationMessageRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ConversationMessageRow(users: ["qbe6jIfSSiSkwQhrNXYuLg": Conversation.User(id: "qbe6jIfSSiSkwQhrNXYuLg",
                                                                                       name: "John Doe",
                                                                                       profilePhotoUrl: "https://i.scdn.co/image/ab67616d0000b273da5658301db50de20d4d6106")],
                                   message: Conversation.Message(id: "CxBZSRw/QISi4xHC2SQ9mg",
                                                                 actorId: "n0p40O9FSWqxTwn4Nf+D+Q",
                                                                 content: "message content",
                                                                 date: Date()))                
            .previewLayout(.sizeThatFits)
            .padding()
        }
    }
}
