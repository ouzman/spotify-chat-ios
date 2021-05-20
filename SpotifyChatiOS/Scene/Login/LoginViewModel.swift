//
//  LoginViewModel.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 13.05.2021.
//

import Foundation
import AuthenticationServices
import Combine

class LoginViewModel: NSObject, ObservableObject, ASWebAuthenticationPresentationContextProviding {
    let url = URL(string: "https://tp25n41kxj.execute-api.eu-west-1.amazonaws.com/login")!
    private var cancellables = Set<AnyCancellable>()

    // MARK: - ASWebAuthenticationPresentationContextProviding
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
    
    func signIn() {
        let signInPromise = Future<URL, Error> { [weak self] completion in
            guard let self = self else { return }
            let authSession = ASWebAuthenticationSession(
                url: self.url,
                callbackURLScheme: URL(string: "spotify-chat")?.fragment) { (url, error) in
                if let error = error {
                    completion(.failure(error))
                } else if let url = url {
                    completion(.success(url))
                }
            }
            
            authSession.presentationContextProvider = self
            authSession.prefersEphemeralWebBrowserSession = false
            authSession.start()
        }
        
        signInPromise.sink { (completion) in
            switch completion {
            case .failure:
                break
            default: break
            }
        } receiveValue: { (url) in
            self.processResponseURL(url: url)
        }
        .store(in: &cancellables)
    }
    
    func processResponseURL(url: URL) {
        guard let url = URLComponents.init(url: url, resolvingAgainstBaseURL: false) else { return }
        let apiKey = url.queryItems?.first(where: { $0.name == "apikey" })?.value
        let userId = url.queryItems?.first(where: { $0.name == "userId" })?.value
        MainViewState.instance.apiKey = apiKey
        MainViewState.instance.userId = userId
        MainViewState.instance.activeScene = .chat
    }
}
