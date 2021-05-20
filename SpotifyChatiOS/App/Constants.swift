//
//  Constants.swift
//  SpotifyChatiOS
//
//  Created by Oguzhan Uzman on 20.05.2021.
//

enum Constants {
    enum UserDefaultsKey {
        static let ApiKey = "SC-ApiKey"
        static let UserId = "SC-UserId"
    }
    
    enum ExternalService {
        enum Url {
            static let LoginApi = "https://tp25n41kxj.execute-api.eu-west-1.amazonaws.com"
            static let ChatApi = "wss://s7rwqp3id5.execute-api.eu-west-1.amazonaws.com/prod"
        }
        
        enum Headers {
            static let AuthenticationHeader = "X-SC-ApiKey"
        }
    }
}
