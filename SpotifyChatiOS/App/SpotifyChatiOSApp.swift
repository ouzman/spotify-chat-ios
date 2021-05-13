//
//  SpotifyChatiOSApp.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 13.05.2021.
//

import SwiftUI

@main
struct SpotifyChatiOSApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(AppState.instance)
        }
    }
}
