//
//  ViewExtensions.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 19.05.2021.
//

import SwiftUI

extension View {
    func alert(isPresented: Binding<Bool>,
               title: String,
               message: String? = nil,
               dismissButton: Alert.Button? = nil) -> some View {

        alert(isPresented: isPresented) {
            Alert(title: Text(title),
                  message: {
                    if let message = message { return Text(message) }
                    else { return nil } }(),
                  dismissButton: dismissButton)
        }
    }
}
