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
    var title: String {
        return "\(conversation.song.artist) - \(conversation.song.name)"
    }
    var subtitle: String? {
        if let lastMessage = conversation.lastMessage {
            let username = conversation.users[lastMessage.actorId]?.name.split(separator: " ", maxSplits: 1, omittingEmptySubsequences: false)[0] ?? ""
            
            return "\(username): \(lastMessage.content)"
        } else {
            return nil
        }
    }
    var date: Date {
        return conversation.lastMessage?.date ?? conversation.date
    }
    
    var day: String {
        return date.getDay()
    }
    
    var time: String {
        return date.getTime()
    }

    var body: some View {
        HStack(spacing: 15) {
            RemoteImage(url: conversation.song.image,
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
            conversation: Conversation(id: "TPmZ8WG4QxGjzdwrR/GjSQ",
                                       date: Date(),
                                       lastMessage: Conversation.Message(id: "CxBZSRw/QISi4xHC2SQ9mg",
                                                                         actorId: "n0p40O9FSWqxTwn4Nf+D+Q",
                                                                         content: "message content",
                                                                         date: Date()),
                                       song: Conversation.Song(id: "11",
                                                               name: "Master Of Life",
                                                               artist: "Khruangbin",
                                                               image: "https://i.scdn.co/image/ab67616d0000b273da5658301db50de20d4d6106"),
                                       users: ["n0p40O9FSWqxTwn4Nf+D+Q": Conversation.User(id: "n0p40O9FSWqxTwn4Nf+D+Q",
                                                                                           name: "John Doe",
                                                                                           profilePhotoUrl: nil),
                                               "pyB2se26SfCw/07gfmt0MA": Conversation.User(id: "pyB2se26SfCw/07gfmt0MA",
                                                                                           name: "Jane Doe",
                                                                                           profilePhotoUrl: "https://platform-lookaside.fbsbx.com/platform/profilepic/?asid=10202819517622673&height=300&width=300&ext=1623763736&hash=AeS2I6q5AzzGf92gzBs")]))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
