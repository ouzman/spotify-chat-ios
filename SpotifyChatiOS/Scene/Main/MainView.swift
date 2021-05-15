//
//  MainView.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 13.05.2021.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var state: MainViewState
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Spotify Chat App")
                NavigationLink(destination: LoginView(viewModel: LoginViewModel()),
                               tag: MainScene.login,
                               selection: Binding<MainScene?>($state.activeScene)) {
                    EmptyView()
                }
                NavigationLink(destination: ConversationView()
                                .environmentObject(ConversationViewState.instance),
                               tag: MainScene.chat,
                               selection: Binding<MainScene?>($state.activeScene)) {
                    EmptyView()
                }
            }
            .navigationBarHidden(true)
        }
        .ignoresSafeArea()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
