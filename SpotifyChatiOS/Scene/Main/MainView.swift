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
                LoginView(viewModel: LoginViewModel())
                    .navigationBarHidden(true)
                
                NavigationLink(
                    destination: ConversationView().environmentObject(ConversationViewState.instance),
                    isActive: $state.isLoggedIn,
                    label: {
                        EmptyView()
                    }).navigationBarHidden(true)
            }
        }
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
