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
    
    private var cancellables = Set<AnyCancellable>()
    
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
        guard let apiKey = MainViewState.instance.apiKey else {
            return
        }

        AuthenticationService.instance.logout(apiKey: apiKey)
            .sink { _ in
                self.clearAuthentication()
            } receiveValue: { () in
                self.clearAuthentication()
            }
            .store(in: &cancellables)
    }
    
    private func clearAuthentication() {
        MainViewState.instance.apiKey = nil
        MainViewState.instance.userId = nil
        MainViewState.instance.activeScene = .login
        ConversationViewState.instance.activeConversation = nil
        ConversationViewState.instance.activeScene = .list

        UserDefaults.standard.removeObject(forKey: Constants.UserDefaultsKey.ApiKey)
        UserDefaults.standard.removeObject(forKey: Constants.UserDefaultsKey.UserId)
    }
}
struct LogoutButton_Previews: PreviewProvider {
    static var previews: some View {
        LogoutButton()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
