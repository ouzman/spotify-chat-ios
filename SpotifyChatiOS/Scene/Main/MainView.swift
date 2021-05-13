//
//  MainView.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 13.05.2021.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var state: AppState
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Mobile File Sharing App")
                NavigationLink(destination: LoginView(viewModel: LoginViewModel()),
                               tag: false,
                               selection: Binding<Bool?>($state.isLoggedIn)) {
                    EmptyView()
                }
                NavigationLink(destination: ChatList(viewModel: ChatListViewModel()),
                               tag: true,
                               selection: Binding<Bool?>($state.isLoggedIn)) {
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
