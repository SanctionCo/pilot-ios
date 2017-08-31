//
//  Router.swift
//  pilot
//
//  Created by Nick Eckert on 8/18/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import HTTPStatusCodes

/// The router builds static content related to the URL such as parameters, headers, etc..
enum LightningRouter: URLRequestConvertible {
    
    case publish(Platform, [String: String]?)
    case extendToken(Platform)
    case getOauthURL(Platform)
    
    static let baseURLString = PilotConfiguration.Lightning.host
    
    // HTTP Method used for each endpoint
    var method: HTTPMethod {
        switch self {
        case .publish:
            return .post
        default:
            return .get
        }
    }
    
    // Path for each request type
    var path: String {
        switch self {
        case .publish(let platform, _):
            return "/\(platform.type.rawValue)/publish"
        case .extendToken(let platform):
            return "/\(platform.type.rawValue)/extendedToken"
        case .getOauthURL(let platform):
            return "/\(platform.type.rawValue)/oauthURL"
        }
    }
    
    var url: URL {
        return URL(string: LightningRouter.baseURLString)!.appendingPathComponent(path)
    }
    
    // How to encode the requet based on the HTTP Method
    var encoding: ParameterEncoding {
        switch self {
        case .publish:
            return URLEncoding(destination: .queryString)
        default:
            return URLEncoding.default
        }
    }
    
    // Paramers for the request
    var parameters: [String: String]? {
        switch self {
        case .publish( _, let parameters):
            return parameters
        default:
            return nil
        }
    }
    
    // MARK: URLRequestConvertable
    
    /// Builds a URLRequest based on enum values
    ///
    /// - Returns: A URLRequest
    /// - Throws: A AFError.parameterEncodingFailed Error
    func asURLRequest() throws -> URLRequest {
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        return try encoding.encode(urlRequest, with: parameters)
    }

}
