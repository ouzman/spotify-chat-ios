//
//  ConversationDetailView.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 13.05.2021.
//

import SwiftUI
import SwiftUIX

struct ConversationDetailView: View {
    @ObservedObject var viewModel: ConversationDetailViewModel
    @EnvironmentObject var state: ConversationViewState
    @State private var message = ""
    var navBarTitle: String {
        guard let conversation = viewModel.conversation else { return "" }
        return "\(conversation.song.artist) - \(conversation.song.name)"
    }
    
    init(viewModel: ConversationDetailViewModel) {
        self.viewModel = viewModel
        self.viewModel.conversation = ConversationViewState.instance.activeConversation
    }
    
    var body: some View {
        VStack {
            // Chat history.
            ScrollView {
                ScrollViewReader { proxy in
                    LazyVStack(spacing: 8) {
                        ForEach(viewModel.messages, id: \.id) { message in
                            ConversationMessageRow(users: viewModel.conversation!.users, message: message)
                        }
                    }
                    .padding(10)
                    .onChange(of: viewModel.messages.count) { _ in
                        scrollToLastMessage(proxy: proxy)
                    }
                }
            }.onTapGesture {
                endEditing()
            }
            
            // Message field.
            HStack {
                CocoaTextField("", text: $message, onEditingChanged: { _ in }, onCommit: onCommit)
                    .isFirstResponder(true)
                    .modifier(PlaceholderStyle(showPlaceHolder: message.isEmpty,
                                                placeholder: "Send a message.."))
                    .padding(10)
                    .padding(.leading, 5)
                    .background(Color.secondary.opacity(0.2))
                    .cornerRadius(5)
                
                Button(action: onCommit) {
                    Image(systemName: "arrowshape.turn.up.right")
                        .font(.system(size: 20))
                        .padding(6)
                }
                .cornerRadius(5)
                .disabled(message.isEmpty)
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle(navBarTitle, displayMode: .inline).font(.subheadline).lineLimit(1)
        .navigationBarItems(leading: backButton,
                                     trailing: LogoutButton())
        .onAppear {
            viewModel.onAppear()
        }
        
    
    }
    
   
    
    var backButton: some View {
        Button(action: {
            state.activeScene = .list
        }) {
            Image(systemName: "chevron.backward")
                .renderingMode(.template)
                .foregroundColor(Color.blue)
        }
        .scaledToFill()
    }
    
    private func scrollToLastMessage(proxy: ScrollViewProxy) {
        if viewModel.messages.last != nil {
            withAnimation(.easeOut(duration: 0.4)) {
                proxy.scrollTo(viewModel.messages[viewModel.messages.endIndex - 1])
            }
        }
    }
    
    private func onCommit() {
        if !message.isEmpty {
            viewModel.sendMessage(text: message)
            message = ""
        }
    }
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
}

public struct PlaceholderStyle: ViewModifier {
    var showPlaceHolder: Bool
    var placeholder: String

    public func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if showPlaceHolder {
                Text(placeholder)
                    .foregroundColor(Color.gray)
                    .italic()
                .padding(.horizontal, 5)
            }
            content
                .padding(.leading, 5)
        }
    }
}

struct ConversationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationDetailView(viewModel: ConversationDetailViewModel())
//            .previewLayout(.sizeThatFits)
//            .padding()
    }
}
