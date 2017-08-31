//
//  NetworkManager.swift
//  pilot
//
//  Created by Nick Eckert on 8/22/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation
import Alamofire

// Contains static instance of SessionManager used for all requests
struct NetworkManager {
    
    static let sharedInstance = Alamofire.SessionManager.default
    
    static func setAuthToken(token: AuthToken) {
        NetworkManager.sharedInstance.adapter = AuthAdapter(authToken: token)
    }
    
}
