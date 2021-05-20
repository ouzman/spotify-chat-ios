//
//  ConversationListView.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 13.05.2021.
//

import SwiftUI
import Combine

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}

struct ConversationListView: View {
    @ObservedObject var viewModel: ConversationListViewModel
    @EnvironmentObject var state: ConversationViewState
    @State var showsAlert = false

    init(viewModel: ConversationListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .bottom) {
                Text("Chats")
                    .padding(.leading, 10)
                    .font(.title, weight: .semibold)
                   
                Spacer()
                
                LogoutButton().padding(.trailing, 20)
            }
            
            LoadingView(isShowing: .constant(viewModel.loading)) {
                VStack() {
                    ScrollView() {
                        LazyVStack(alignment: .leading, spacing: 25) {
                            ForEach(viewModel.conversations, id: \.id) { conversation in

                                Button(action: {
                                    state.activeConversation = conversation
                                    state.activeScene = .detail
                                }) {
                                    ConversationListRow(conversation: conversation)
                                }
                            }
                            .padding()
                        }
                    }

                    Button(action: {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
                            if (self.viewModel.loading) {
                                self.viewModel.loading = false
                                showsAlert = true
                            }
                        }
                        viewModel.loading = true
                        viewModel.matchRequest()
                    }) {
                        Image(systemName: "music.quarternote.3")
                            .renderingMode(.template)
                            .foregroundColor(.white)
                            .padding()

                        Text("Match")
                            .foregroundColor(.white)
                            .padding(.trailing, 40)
                    }
                    .background(Color.blue)
                    .cornerRadius(25)
                    .padding()
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .alert(isPresented: $showsAlert, title: ":(", message: "Uygun bir eşleşme bulunamadı.")
                }
            }
        }
        .onAppear(perform: {
            viewModel.onAppear()
        })
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
}

struct ConversationListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ConversationListView(viewModel: ConversationListViewModel())
                .previewLayout(.sizeThatFits)
                .padding()
        }
    }
}
