//
//  ConversationMessageRow.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 15.05.2021.
//

import SwiftUI

struct ConversationMessageRow: View {
    let message: ConversationMessage
    
    var body: some View {
        HStack {
            if message.isLoggedInUser {
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(message.userName)
                        .fontWeight(.bold)
                        .font(.system(size: 12))
                    
                    Text(message.date.getTime())
                        .font(.system(size: 10))
                        .opacity(0.7)
                }
                
                Text(message.message)
            }
            .foregroundColor(message.isLoggedInUser ? .white : .black)
            .padding(10)
            .background(message.isLoggedInUser ? Color.blue : Color(white: 0.95))
            .cornerRadius(5)
            
            if !message.isLoggedInUser {
                Spacer()
            }
        }
        .transition(.scale(scale: 0, anchor: message.isLoggedInUser ? .topTrailing : .topLeading))
    }
}

struct ConversationMessageRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ConversationMessageRow(
                message: ConversationMessage(
                    type: "NEW_CHAT_MESSAGE",
                    date: "01-01-2021 12:16",
                    message: "message from user1",
                    userName: "user1",
                    isLoggedInUser: true)
            )
            .previewLayout(.sizeThatFits)
            .padding()
            
            ConversationMessageRow(
                message: ConversationMessage(
                    type: "NEW_CHAT_MESSAGE",
                    date: "01-01-2021 12:16",
                    message: "message from user2",
                    userName: "user2",
                    isLoggedInUser: false)
            )
            .previewLayout(.sizeThatFits)
            .padding()
        }
    }
}
