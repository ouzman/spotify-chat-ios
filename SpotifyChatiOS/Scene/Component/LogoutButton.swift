//
//  LogoutButton.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 15.05.2021.
//

import SwiftUI
import Combine

struct LogoutButton: View {
    private let viewModel = LogoutButtonViewModel()
    
    @State private var showAlert = false

    var body: some View {
        Button("Logout", action: { self.showAlert = true })
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text("Logout"),
                      message: Text("User will be logged out. Are you sure?"),
                      primaryButton: .destructive(Text("Logout").bold(),
                                                  action: { viewModel.logout() }),
                      secondaryButton: .cancel())
            })
    }
}

class LogoutButtonViewModel {
    private var cancellables = Set<AnyCancellable>()

    func logout() {
        MainViewState.instance.apiKey = nil
        MainViewState.instance.activeScene = .login
        ChatViewState.instance.activeScene = .chatList
    }
}

struct LogoutButton_Previews: PreviewProvider {
    static var previews: some View {
        LogoutButton()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
