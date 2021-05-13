//
//  ChatListViewModel.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 13.05.2021.
//

import Combine
import Foundation

class ChatListViewModel: ObservableObject {
    private var webSocketTask: URLSessionWebSocketTask?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Connection
    func connect() {
        guard let apiKey = AppState.instance.apiKey else { return }
        let url = URL(string: "wss://my5m5otnpl.execute-api.eu-west-1.amazonaws.com/$default")!
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["X-SC-ApiKey": apiKey]
        let session = URLSession(configuration: configuration)
        webSocketTask = session.webSocketTask(with: url)
        webSocketTask?.receive(completionHandler: onReceive)
        webSocketTask?.resume()
        
        //TODO update it
        webSocketTask?.send(.string(#"{"naber": "maho"}"#)) { error in // 3
            if let error = error {
                print("Error sending message", error) // 4
            }
        }
    }
    
    func disconnect() {
        print("disconnect")
        webSocketTask?.cancel(with: .normalClosure, reason: nil)
    }
    
    private func onReceive(incoming: Result<URLSessionWebSocketTask.Message, Error>) {
        webSocketTask?.receive(completionHandler: onReceive)
        
        // TODO
        incoming.publisher.sink { error in
            // TODO
        } receiveValue: { message in
            print(message)
        }
        .store(in: &cancellables)
        
    }
    
    deinit {
        disconnect()
    }
}
