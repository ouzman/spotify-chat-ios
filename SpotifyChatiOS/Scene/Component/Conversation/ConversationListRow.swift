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
            RemoteImage(url: conversation.song.image,
                        loading: Image("spotify-logo"),
                        failure: Image("spotify-logo"))
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .shadow(radius: 10)
            
            
            VStack(alignment: .leading) {
                if let lastMessage = conversation.lastMessage {
                    Text("Khruangbin - Master Of Life")
                        .font(.system(size: 15))
                        .lineLimit(1)
                        .padding(.bottom, 1)
                    
                    let userName = conversation.users[lastMessage.actorId]?.name ?? ""
                    let wholeMessageText = userName.isEmpty ? lastMessage.content : "\(userName): \(lastMessage.content)"
                    Text(wholeMessageText)
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
            conversation: Conversation(id: "TPmZ8WG4QxGjzdwrR/GjSQ",
                                       lastMessage: Conversation.Message(id: "CxBZSRw/QISi4xHC2SQ9mg",
                                                                         actorId: "n0p40O9FSWqxTwn4Nf+D+Q",
                                                                         content: "message content",
                                                                         date: "2021-05-16T14:28:06.002Z"),
                                       song: Conversation.Song(name: "Master Of Life",
                                                               artist: "Khruangbin",
                                                               image: "https://i.scdn.co/image/ab67616d0000b273da5658301db50de20d4d6106"),
                                       users: ["qbe6jIfSSiSkwQhrNXYuLg": Conversation.User(id: "qbe6jIfSSiSkwQhrNXYuLg",
                                                                                           name: "John Doe",
                                                                                           profilePhotoUrl: nil),
                                               "pyB2se26SfCw/07gfmt0MA": Conversation.User(id: "pyB2se26SfCw/07gfmt0MA",
                                                                                           name: "Jane Doe",
                                                                                           profilePhotoUrl: "https://platform-lookaside.fbsbx.com/platform/profilepic/?asid=10202819517622673&height=300&width=300&ext=1623763736&hash=AeS2I6q5AzzGf92gzBs")]))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
