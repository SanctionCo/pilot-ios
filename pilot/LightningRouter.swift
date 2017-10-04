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

  case publish(PlatformType, [String: Any]?)
  case extendToken(PlatformType)
  case getOauthURL(PlatformType)

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
    case .publish(let type, _):
      return "/\(type.rawValue)/publish"
    case .extendToken(let type):
      return "/\(type.rawValue)/extendedToken"
    case .getOauthURL(let type):
      return "/\(type.rawValue)/oauthUrl"
    }
  }

  var url: URL {
    return URL(string: LightningRouter.baseURLString)!.appendingPathComponent(path)
  }

  // How to encode the requet based on the endpoint
  var encoding: ParameterEncoding {
    switch self {
    case .publish, .getOauthURL:
      return URLEncoding(destination: .queryString)
    default:
      return URLEncoding.default
    }
  }

  // Paramers for the request
  var dynamicparameters: [String: Any]? {
    switch self {
    case .publish( _, let parameters):
      return parameters
    case .getOauthURL(let type):
      switch type {
      case .facebook:
        return ["redirect": PilotConfiguration.Lightning.facebookRedirectURL]
      case .twitter:
        return ["redirect": PilotConfiguration.Lightning.twitterRedirectURL]
      }
    default:
      return nil
    }
  }

  var staticParameters: [String: Any]? {
    switch self {
    case .getOauthURL:
      return nil
    default:
      return ["email": UserManager.sharedInstance!.getEmail()]
    }
  }

  var staticHeaders: [String: String]? {
    switch self {
    case .getOauthURL:
      return nil
    default:
      return ["password": UserManager.sharedInstance!.getPassword()]
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

    // Set static headers if needed
    if let staticHeaders = staticHeaders {
      for (key, value) in staticHeaders {
        urlRequest.setValue(value, forHTTPHeaderField: key)
      }
    }

    // Set the static parameters if needed
    if let staticParameters = staticParameters {
      urlRequest = try encoding.encode(urlRequest, with: staticParameters)
    }

    return try encoding.encode(urlRequest, with: dynamicparameters)
  }

}
