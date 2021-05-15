//
//  LoginView.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 13.05.2021.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    let spotifyGreen = UIColor(named: "spotifyGreen") ?? .green
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: nil, content: {
            Spacer()
            self.loginButton
            Spacer()
        })
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
    }
    
    var loginButton: some View {
        Button(action: {
            viewModel.signIn()
        }) {
            HStack {
                Image("spotify-logo")
                    .renderingMode(.template)
                    .foregroundColor(.white)
                Spacer().frame(width: 15)
                Text("Login with Spotify")
            }
            .padding()
        }
        
        .foregroundColor(.white)
        .background(Color(spotifyGreen))
        .cornerRadius(25)
        .font(.system(size: 18, weight: .semibold, design: .rounded))
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel())
    }
}

