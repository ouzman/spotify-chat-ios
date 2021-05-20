//
//  LoginViewModel.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 13.05.2021.
//

import Foundation
import AuthenticationServices
import Combine

class LoginViewModel: NSObject, ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    
    func signIn() {
        AuthenticationService.instance.signIn().sink { (completion) in
            switch completion {
            case .failure:
                break
            default: break
            }
        } receiveValue: { (response) in
            guard let response = response else {
                return
            }
            self.processAuthenticationResponse(authResponse: response)
        }
        .store(in: &cancellables)
    }
    
    private func processAuthenticationResponse(authResponse: AuthenticationResponse) {
        UserDefaults.standard.setValue(authResponse.apiKey, forKey: Constants.UserDefaultsKey.ApiKey)
        UserDefaults.standard.setValue(authResponse.userId, forKey: Constants.UserDefaultsKey.UserId)
        
        MainViewState.instance.apiKey = authResponse.apiKey
        MainViewState.instance.userId = authResponse.userId
        MainViewState.instance.activeScene = .chat
    }
}
