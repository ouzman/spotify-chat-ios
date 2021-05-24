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
    static let user1 = Conversation.User(id: "user1",
                                  name: "Test User 1",
                                  profilePhotoUrl: nil)
    static let user2 = Conversation.User(id: "user2",
                                  name: "Test User 2",
                                  profilePhotoUrl: nil)

    static let message1 = Conversation.Message(id: "message1",
                                        actorId: user1.id,
                                        content: "message content 1",
                                        date: Date())

    static let message2 = Conversation.Message(id: "message2",
                                        actorId: user2.id,
                                        content: "message content 2",
                                        date: Date())

    init() {
        
    }
    
    @ViewBuilder static func generatePreviews() -> some View {
        MainViewState.instance.userId = Self.user1.id
        
        return Group {
            ConversationMessageRow(users: [
                Self.user1.id: Self.user1,
                Self.user2.id: Self.user2
            ],
                                   message: Self.message1)
                .previewLayout(.sizeThatFits)
                .padding()

            ConversationMessageRow(users: [
                Self.user1.id: Self.user1,
                Self.user2.id: Self.user2
            ],
                                   message: Self.message2)
            .previewLayout(.sizeThatFits)
            .padding()
        }
    }
    
    static var previews: some View = Self.generatePreviews()
}
