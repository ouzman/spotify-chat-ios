//
//  AuthenticationService.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 20.05.2021.
//

import Foundation
import AuthenticationServices
import Combine

struct AuthenticationResponse {
    let apiKey: String
    let userId: String
}

class AuthenticationService: NSObject, ASWebAuthenticationPresentationContextProviding {
    private static let baseUrl = URL(string: Constants.ExternalService.Url.LoginApi)!
    private static let authenticationHeaderName = Constants.ExternalService.Headers.AuthenticationHeader
    private static let loginPath = "/login"
    private static let logoutPath = "/logout"
    

    static let instance = AuthenticationService()
    
    private override init() { }

    // MARK: - ASWebAuthenticationPresentationContextProviding
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
    
    func signIn() -> AnyPublisher<AuthenticationResponse?, Error> {
        let loginUrl = URL(string: Self.loginPath, relativeTo: Self.baseUrl)!
        
        let signInPromise = Future<URL, Error> { [weak self] completion in
            guard let self = self else { return }
            let authSession = ASWebAuthenticationSession(
                url: loginUrl,
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
        
        return signInPromise
            .map { (url) -> AuthenticationResponse? in
                Self.processResponseURL(url: url)
            }
            .eraseToAnyPublisher()
        
    }
    
    private static func processResponseURL(url: URL) -> AuthenticationResponse? {
        guard let url = URLComponents.init(url: url, resolvingAgainstBaseURL: false) else { return nil }
        let apiKey = url.queryItems?.first(where: { $0.name == "apikey" })?.value
        let userId = url.queryItems?.first(where: { $0.name == "userId" })?.value
        return AuthenticationResponse(apiKey: apiKey!, userId: userId!)
    }
    
    func logout(apiKey: String) -> AnyPublisher<Void, URLError> {
        let logoutUrl = URL(string: Self.loginPath, relativeTo: Self.baseUrl)!
        var request = URLRequest(url: logoutUrl)
        request.httpMethod = "POST"
        request.addValue(apiKey, forHTTPHeaderField: Self.authenticationHeaderName)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { (_: Data, _: URLResponse) in
                return
            }
            .eraseToAnyPublisher()
    }
}
