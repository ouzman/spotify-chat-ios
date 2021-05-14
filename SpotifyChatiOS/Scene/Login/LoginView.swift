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
                .frame(minWidth: 0,
                       idealWidth: .infinity,
                       maxWidth: .infinity,
                       maxHeight: 40,
                       alignment: .center)
                .padding(.all)
                .padding(.bottom, 20)
            Spacer()
        })
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
    }
    
    var loginButton: some View {
        Button(action: {
            viewModel.signIn()
        }) {
            Image("spotify-logo")
                .renderingMode(.template)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: -40))
                .font(.largeTitle)
                .foregroundColor(.white)
            Text("Login with Spotify")
                .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity,
                       minHeight: 0, idealHeight: 100, maxHeight: .infinity,
                       alignment: .center)

        }
        .foregroundColor(.white)
        .background(Color(spotifyGreen))
        .cornerRadius(25)
        .font(.system(size: 18, weight: .semibold, design: .rounded))
        .frame(width: 250, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel())
    }
}

