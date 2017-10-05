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
/// NOTE: An adapter is nessissary to allow retrying connections since a Router is only called once per request.
class AuthAdapter: RequestAdapter {

  init() { }

  // This is called each time Alamofire is going to make a request
  func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
    var urlRequest = urlRequest

    // Set static request headers
    if let urlString = urlRequest.url?.absoluteString, urlString.hasPrefix(PilotConfiguration.Lightning.host) {
      urlRequest.setValue("Basic \(PilotConfiguration.Lightning.basicCredentials)", forHTTPHeaderField: "Authorization")
    } else if let urlString = urlRequest.url?.absoluteString, urlString.hasPrefix(PilotConfiguration.Thunder.host) {
      urlRequest.setValue("Basic \(PilotConfiguration.Thunder.basicCredentials)", forHTTPHeaderField: "Authorization")
    }

    return urlRequest
  }

}
