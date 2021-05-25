//
//  ConversationListRow.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 15.05.2021.
//

import SwiftUI
import Combine

struct ConversationListRowModel {
    let artistName: String
    let songName: String
    let songImage: String?
    let lastMessageActorName: String?
    let lastMessageContent: String?
    let lastUpdatedDate: Date
}

struct ConversationListRow: View {
    let conversationListRowModel: ConversationListRowModel
    var title: String {
        return "\(conversationListRowModel.artistName) - \(conversationListRowModel.songName)"
    }
    var subtitle: String? {
        guard let lastMessageActorName = conversationListRowModel.lastMessageActorName,
              let lastMessageContent = conversationListRowModel.lastMessageContent else {
            return nil
        }
        return "\(lastMessageActorName.split(separator: " ")[0]): \(lastMessageContent)"
    }
    
    var day: String {
        return conversationListRowModel.lastUpdatedDate.getDay()
    }
    
    var time: String {
        return conversationListRowModel.lastUpdatedDate.getTime()
    }

    var body: some View {
        HStack(spacing: 15) {
            RemoteImage(url: conversationListRowModel.songImage,
                        loading: Image("spotify-logo"),
                        failure: Image("spotify-logo"))
                .clipShape(Circle())
                .shadow(radius: 10)
            
            
            VStack(alignment: .leading, spacing: 5) {
                Text(self.title)
                    .font(.headline)
                    .foregroundColor(.black)
                    .bold()
                    .lineLimit(1)
                    .padding(.bottom, 1)

                if let subtitle = self.subtitle {
                    Text(subtitle)
                        .font(.subheadline)
                        .italic()
                        .foregroundColor(.black)
                        .lineLimit(1)
                }
            }
                        
            Spacer()
            VStack(alignment: .trailing) {
                Text(self.day).font(.caption).foregroundColor(.black)
                Text(self.time).font(.caption2).foregroundColor(.black)
            }
        }
    }
}

struct ConversationListRow_Previews: PreviewProvider {
    static var previews: some View {
        ConversationListRow(
            conversationListRowModel: ConversationListRowModel(artistName: "Khruangbin",
                                                               songName: "Master Of Life",
                                                               songImage: "https://i.scdn.co/image/ab67616d0000b273da5658301db50de20d4d6106",
                                                               lastMessageActorName: "John Doe",
                                                               lastMessageContent: "message content",
                                                               lastUpdatedDate: Date()))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
