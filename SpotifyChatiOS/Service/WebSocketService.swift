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
    static let instance = WebSocketService()
    private var webSocketTask: URLSessionWebSocketTask?
    private var cancellables = Set<AnyCancellable>()
    private var consumers = [String: ConsumerDefinition]()
    
    private init() {
        //TODO: remove it
        let timer1 = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(oneTime), userInfo: nil, repeats: true)
//        let timer2 = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(always), userInfo: nil, repeats: true)

    }

    
    @objc func oneTime() {
        let event = "{\"eventId\":\"UkAJsxQeR0ulVd1Vn81yiw\",\"date\":\"2021-05-16T14:28:06.001Z\",\"action\":\"NewConversation\",\"data\":{\"conversation\":{\"id\":\"\(Int.random(in: 1...100))\",\"lastMessage\":{\"id\":\"CxBZSRw/QISi4xHC2SQ9mg\",\"actorId\":\"n0p40O9FSWqxTwn4Nf+D+Q\",\"content\":\"message content\",\"date\":\"2021-05-16T14:28:06.002Z\"},\"song\":{\"name\":\"Master Of Life\",\"artist\":\"Khruangbin\",\"image\":\"https://i.scdn.co/image/ab67616d0000b273da5658301db50de20d4d6106\"},\"users\":[{\"id\":\"qbe6jIfSSiSkwQhrNXYuLg\",\"name\":\"John Doe\",\"profilePhotoUrl\":null},{\"id\":\"pyB2se26SfCw/07gfmt0MA\",\"name\":\"Jane Doe\",\"profilePhotoUrl\":\"https://platform-lookaside.fbsbx.com/platform/profilepic/?asid=10202819517622673&height=300&width=300&ext=1623763736&hash=AeS2I6q5AzzGf92gzBs\"}]}}}"

        consumers["NewConversation"]?.consume(event.data(using: .utf8)!)
    }
    
    @objc func always() {
        let i = Int(Date().timeIntervalSince1970)
        let actorId = Bool.random() ? "qbe6jIfSSiSkwQhrNXYuLg" : "pyB2se26SfCw/07gfmt0MA"

        let event = "{\"eventId\":\"CwOGx6cMSMybK/+r0fTAXg\",\"date\":\"2021-05-16T14:28:06.002Z\",\"action\":\"NewMessage\",\"data\":{\"conversationId\":\"babus\",\"message\":{\"id\":\"\(i))\",\"actorId\":\"\(actorId)\",\"content\":\"message content\",\"date\":\"\(i)\"}}}"
        
        consumers["NewMessage"]?.consume(event.data(using: .utf8)!)
    }
    

    func registerConsumer(messageType: String,
                          consumer: @escaping (Data) -> Void) {
        let definition = ConsumerDefinition(
            type: messageType,
            consume: consumer)
        
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
//        webSocketTask?.resume()
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
                  let chatMessage = try? JSONDecoder().decode(BasicSocketEvent.self, from: data)
            else {
                print("Invalid message schema recieved \(text)")
                return
            }
            
            guard let consumerDefinition = self.consumers[chatMessage.action] else {
                print("Unknown message type \(chatMessage.action)")
                return
            }
            
            consumerDefinition.consume(data)
            
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
