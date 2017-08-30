//
//  LightningAdapter.swift
//  pilot
//
//  Created by Nick Eckert on 8/18/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import HTTPStatusCodes


/// Inserts dynamic authentication data such as Basic auth and password headers required for each request.
/// NOTE: An adapter is nessissary to allow retrying connections since a Router is only called once at the beginning of a request
class AuthAdapter: RequestAdapter {
    
    private var authToken: AuthToken       // Token used for authentication headers and query parameters
    
    init(authToken: AuthToken) {
        self.authToken = authToken
    }
    
    // This is called each time Alamofire is going to make a request
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        
        // Set dynamic request headers
        if let urlString = urlRequest.url?.absoluteString, urlString.hasPrefix(PilotConfiguration.Lightning.host) {
            urlRequest.setValue(authToken.password, forHTTPHeaderField: "password")
            urlRequest.setValue("Basic \(PilotConfiguration.Lightning.basicCredentials)", forHTTPHeaderField: "Authorization")
        }
        
        // Set dynamic query parameters
        return try URLEncoding(destination: .queryString).encode(urlRequest, with: ["email": authToken.email])
    }
    
}
