//
//  ConversationDetailView.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 13.05.2021.
//

import SwiftUI

struct ConversationDetailView: View {
    @ObservedObject var viewModel: ConversationDetailViewModel
    @EnvironmentObject var state: ConversationViewState
    @State private var message = ""
    
    init(viewModel: ConversationDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            // Chat history.
            ScrollView {
                ScrollViewReader { proxy in
                    LazyVStack(spacing: 8) {
                        ForEach(viewModel.messages) { message in
                            ConversationMessageRow(message: message)
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
                TextField("", text: $message, onEditingChanged: { _ in }, onCommit: onCommit)
                    .padding(10)
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
        .navigationBarItems(leading: backButton,
                            trailing: LogoutButton())
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
            viewModel.send(text: message)
            message = ""
        }
    }
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
}

struct ConversationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationDetailView(viewModel: ConversationDetailViewModel())
    }
}
