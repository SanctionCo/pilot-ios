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
    
    case create([String: String]?)
    case update([String: String]?)
    case fetch([String: String]?)
    case delete([String: String]?)
    
    static let baseURLString = PilotConfiguration.Thunder.endpoint
    
    // HTTP Method used for each request action
    var method: HTTPMethod {
        switch self {
        case .create:
            return .post
        case .update:
            return .put
        case .fetch:
            return .get
        case .delete:
            return .delete
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
        case .create:
            return URLEncoding(destination: .queryString)
        default:
            return URLEncoding.default
        }
    }
    
    // Paramers for the request
    var parameters: [String: String]? {
        switch self {
        case .create(let params):
            return params
        case .update(let params):
            return params
        case .fetch(let params):
            return params
        case .delete(let params):
            return params
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
        
        return try encoding.encode(urlRequest, with: parameters)
    }
    
}
