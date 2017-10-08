//
//  ThunderRouter.swift
//  pilot
//
//  Created by Nick Eckert on 8/20/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Alamofire
import Foundation
import HTTPStatusCodes

/// The router builds static content related to the URL such as parameters, headers, etc..
enum ThunderRouter: URLRequestConvertible {

  case login(String, String)      // Email and password encoded in request as apposed to the adapter
  case fetchPilotUser()           // Email param
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
    case .fetchPilotUser, .deletePilotUser, .login:
      return URLEncoding(destination: .queryString)
    }
  }

  // Dynamic paramers for the request
  var dynamicParameters: [String: Any]? {
    switch self {
    case .login(let email, _):
      return ["email": email]
    case .createPilotUser(let pilotUser):
      return pilotUser.toJSON()
    case .updatePilotUser(let pilotUser):
      return pilotUser.toJSON()
    default:
      return nil
    }
  }

  var staticParameters: [String: Any]? {
    switch self {
    case .createPilotUser, .login:
      return nil
    default:
      return ["email": UserManager.sharedInstance!.getAuthenticationEmail()]
    }
  }

  // Heaers for the request
  var staticHeaders: [String: String]? {
    switch self {
    case .login( _, let password):
      return ["password": password]
    case .createPilotUser:
      return nil
    default:
      return ["password": UserManager.sharedInstance!.getAuthenticationPassword()]
    }
  }

  var contentType: String {
    return "application/json"
  }

  // MARK: URLRequestConvertable

  /// Builds a URLRequest based on enum values
  ///
  /// - Returns: A URLRequest
  /// - Throws: A AFError.parameterEncodingFailed Error
  func asURLRequest() throws -> URLRequest {

    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = method.rawValue

    // Set the content-type
    urlRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")

    // If static headers exist then set them!
    if let staticHeaders = staticHeaders {
      for (key, value) in staticHeaders {
        urlRequest.setValue(value, forHTTPHeaderField: key)
      }
    }

    // Set the static parameters if needed
    if let staticParameters = staticParameters {
      urlRequest = try encoding.encode(urlRequest, with: staticParameters)
    }

    return try encoding.encode(urlRequest, with: dynamicParameters)
  }

}
