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
    
    private var pilotUser: PilotUser       // Pilot user used for authentication headers
    
    init(pilotUser: PilotUser) {
        self.pilotUser = pilotUser
    }
    
    // This is called each time Alamofire is going to make a request
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        
        let basicCredentials = "\(PilotConfiguration.Lightning.userKey):\(PilotConfiguration.Lightning.userSecret)"
            .data(using: String.Encoding.utf8)!.base64EncodedString(options: [])
        
        // Set dynamic request headers
        //if let urlString = urlRequest.url?.absoluteString, urlString.hasPrefix(PilotConfiguration.Lightning.endpoint) {
            urlRequest.setValue(pilotUser.password, forHTTPHeaderField: "password")                 // Password header
            urlRequest.setValue("Basic \(basicCredentials)", forHTTPHeaderField: "Authorization")   // Basic auth header
        //}
        
        // Set dynamic query parameters
        return try URLEncoding(destination: .queryString).encode(urlRequest, with: ["email": pilotUser.email])
    }
    
}
