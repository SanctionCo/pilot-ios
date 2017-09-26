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
    
    // Called when a platform returns an OAuth token
    static var authCompletionHandler: (() -> Void)?
    static var authErrorHandler: ((Error) -> Void)?
    
    // Called to refresh HomeView
    static var authHomeViewHandler: (() -> Void)?
    
}
