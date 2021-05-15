//
//  WebSocketService.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 14.05.2021.
//

import Foundation
import Combine

struct ConsumerDefinition {
    let type: String
    let consumer: (Data) -> Void
}

class WebSocketService {
    static let instance = WebSocketService()
    private var webSocketTask: URLSessionWebSocketTask?
    private var cancellables = Set<AnyCancellable>()
    private var consumers = [String: ConsumerDefinition]()
    
    private init() { }

    func registerConsumer(messageType: String,
                          consumer: @escaping (Data) -> Void) {
        let definition = ConsumerDefinition(
            type: messageType,
            consumer: consumer)
        
        consumers[messageType] = definition
    }
    
    // MARK: - Connection
    func connect() {
        guard webSocketTask == nil else { return }
        
        guard let apiKey = MainViewState.instance.apiKey else { return }
        let url = URL(string: "wss://my5m5otnpl.execute-api.eu-west-1.amazonaws.com/$default")!
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["X-SC-ApiKey": apiKey]
        let session = URLSession(configuration: configuration)
        webSocketTask = session.webSocketTask(with: url)
        
        webSocketTask?.receive(completionHandler: onReceive)
        webSocketTask?.resume()
    }
    
    func disconnect() {
        print("disconnect")
        webSocketTask?.cancel(with: .normalClosure, reason: nil)
    }
    
    deinit {
        disconnect()
    }
    
    private func onReceive(incoming: Result<URLSessionWebSocketTask.Message, Error>) {
        webSocketTask?.receive(completionHandler: onReceive)

        incoming
            .publisher
            .receive(on: RunLoop.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    print("Error", error.localizedDescription)
                }
            } receiveValue: { result in
                self.onMessage(message: result)
            }
            .store(in: &cancellables)
    }
    
    private func onMessage(message: URLSessionWebSocketTask.Message) {

        if case .string(var text) = message {
            // TODO: remove dummy data
            text = #"{"type": "NEW_CHAT_MESSAGE", "date": "01-01-2021 12:16", "message": "message1", "userName": "user1", "isLoggedInUser": true}"#
            guard let data = text.data(using: .utf8),
                  let chatMessage = try? JSONDecoder().decode(BasicSocketMessage.self, from: data)
            else {
                print("Invalid message schema recieved \(text)")
                return
            }
            
            guard let consumerDefinition = self.consumers[chatMessage.type] else {
                print("Unknown message type \(chatMessage.type)")
                return
            }
            
            consumerDefinition.consumer(data)
            
        } else {
            print("Unknown socket message \(message)")
        }
    }
    
    func send(text: String) {
        let message = NewConversationMessage(message: text)
        guard let json = try? JSONEncoder().encode(message),
              let jsonString = String(data: json, encoding: .utf8)
        else {
            return
        }
    
        webSocketTask?.send(.string(jsonString)) { error in
            if let error = error {
                print("Error sending message", error)
            }
        }
    }
}
