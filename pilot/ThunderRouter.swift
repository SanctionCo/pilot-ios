//
//  ThunderRouter.swift
//  pilot
//
//  Created by Nick Eckert on 8/20/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import HTTPStatusCodes

/// The router builds static content related to the URL such as parameters, headers, etc..
enum ThunderRouter: URLRequestConvertible {
    
    case login(String, String)      // Email and password encoded in request as apposed to the adapter
    case fetchPilotUser()           // Email param in auth adapter
    case updatePilotUser(PilotUser) // Maps PilotUser to JSON
    case createPilotUser(PilotUser) // Maps PilotUser to JSON
    case deletePilotUser()          // Email param in auth adapter
    
    static let baseURLString = PilotConfiguration.Thunder.host
    
    // HTTP Method used for each request action
    var method: HTTPMethod {
        switch self {
        case .createPilotUser:
            return .post
        case .updatePilotUser:
            return .put
        case .fetchPilotUser:
            return .get
        case .deletePilotUser:
            return .delete
        case .login:
            return .get
        }
    }
    
    // Path for each request type
    var path: String {
        return "/users"
    }
    
    var url: URL {
        return URL(string: ThunderRouter.baseURLString)!.appendingPathComponent(path)
    }
    
    // How to encode the requet based on the HTTP Method
    var encoding: ParameterEncoding {
        switch self {
        case .createPilotUser, .updatePilotUser:
            return JSONEncoding.default
        default:
            return URLEncoding.default
        }
    }
    
    // Paramers for the request
    var parameters: [String: String]? {
        switch self {
        case .login(let email, _):
            return ["email": email]
        default:
            return nil
        }
    }
    
    // Heaers for the request
    var headers: [String: String]? {
        switch self {
        case .login( _, let password):
            return ["password": password, "Authorization": "Basic \(PilotConfiguration.Thunder.basicCredentials)"]
        default:
            return nil
        }
    }
    
    // MARK: URLRequestConvertable
    
    /// Builds a URLRequest based on enum values
    ///
    /// - Returns: A URLRequest
    /// - Throws: Error or something idk
    func asURLRequest() throws -> URLRequest {
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        // If headers exist then set them!
        if let headers = headers {
            for (key, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        return try encoding.encode(urlRequest, with: parameters)
    }
    
}
