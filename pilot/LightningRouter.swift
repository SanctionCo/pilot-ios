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
    
    case users(PlatformType, [String: String]?)
    case photos(PlatformType, [String: String]?)
    case videos(PlatformType, [String: String]?)
    case publish(PlatformType, [String: String]?)
    case extendedToken(PlatformType, [String: String]?)
    case oauthUrl(PlatformType, [String: String]?)
    
    // TODO: Possibly return a tuple of needed values?

    static let baseURLString = PilotConfiguration.Lightning.endpoint
    
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
        case .users(let type, _):
            return "/\(type.rawValue)/users"
        case .photos(let type, _):
            return "/\(type.rawValue)/photos"
        case .videos(let type, _):
            return "/\(type.rawValue)/videos"
        case .publish(let type, _):
            return "/\(type.rawValue)/publish"
        case .extendedToken(let type, _):
            return "/\(type.rawValue)/extendedToken"
        case .oauthUrl(let type, _):
            return "/\(type.rawValue)/oauthUrl"
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
        case .users( _, let params):
            return params
        case .photos( _, let params):
            return params
        case .videos( _, let params):
            return params
        case .publish( _, let params):
            return params
        case .extendedToken( _, let params):
            return params
        case .oauthUrl( _, let params):
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
