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
    let consume: (Data) -> Void
}

class WebSocketService {
    private static let EndpointUrl = URL(string: Constants.ExternalService.Url.ChatApi)!
    private static let AuthenticationHeaderName = Constants.ExternalService.Headers.AuthenticationHeader
    
    static let instance = WebSocketService()
    private var webSocketTask: URLSessionWebSocketTask?
    private var cancellables = Set<AnyCancellable>()
    private var consumers = [String: [ConsumerDefinition]]()

    func registerConsumer(messageType: String,
                          consumer: @escaping (Data) -> Void) {
        let definition = ConsumerDefinition(
            type: messageType,
            consume: consumer)
        
        if consumers[messageType] == nil {
            consumers[messageType] = []
        }
        
        consumers[messageType]?.append(definition)
    }
    
    // MARK: - Connection
    func connect() {
        guard webSocketTask == nil else { return }
        
        guard let apiKey = MainViewState.instance.apiKey else { return }

        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = [Self.AuthenticationHeaderName: apiKey]
        let session = URLSession(configuration: configuration)
        
        webSocketTask = session.webSocketTask(with: Self.EndpointUrl)
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
        
        if case .string(let text) = message {
            guard let data = text.data(using: .utf8),
                  let chatMessage = try? JSONDecoder().decode(BasicSocketEvent.self, from: data)
            else {
                print("Invalid message schema recieved \(text)")
                return
            }
            
            self.consume(eventType: chatMessage.action, data: data)
        } else {
            print("Unknown socket message \(message)")
        }
    }
    
    func consume(eventType: String, data: Data) {
        guard let consumers = self.consumers[eventType] else {
            print("Unknown message type \(eventType)")
            return
        }
        
        consumers.forEach { $0.consume(data) }
    }
    
    func send<T: Encodable>(clientEvent: T) {
        guard let json = try? JSONEncoder().encode(clientEvent),
              let jsonString = String(data: json, encoding: .utf8)
        else {
            return
        }
        
        webSocketTask?.send(.string(jsonString)) { error in
            if let error = error {
                print("Error sending event", error)
            }
        }
    }
}
