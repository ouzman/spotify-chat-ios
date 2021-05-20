//
//  SpotifyChatiOSApp.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 13.05.2021.
//

import SwiftUI

@main
struct SpotifyChatiOSApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(MainViewState.instance)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let apiKey = UserDefaults.standard.string(forKey: Constants.UserDefaultsKey.ApiKey)
        let userId = UserDefaults.standard.string(forKey: Constants.UserDefaultsKey.UserId)
        
        if let apiKey = apiKey,
              let userId = userId {
            MainViewState.instance.apiKey = apiKey
            MainViewState.instance.userId = userId
            MainViewState.instance.activeScene = .chat
        }

        return true
    }
}

