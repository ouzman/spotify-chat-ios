//
//  MainViewState.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 13.05.2021.
//

import Foundation
import Combine

enum MainScene {
    case login
    case chat
}

class MainViewState: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    static let instance = MainViewState()

    private init() {}
    
    @Published var apiKey: String?
    @Published var activeScene: MainScene = .login
}
