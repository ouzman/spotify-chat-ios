//
//  AppState.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 13.05.2021.
//

import Foundation
import Combine

class AppState: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    static let instance = AppState()

    private init() {}
    
    @Published var apiKey: String?
    @Published var activeScene: ActiveScene = .login
}
