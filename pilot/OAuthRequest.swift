//
//  TwitterOAuthRequest.swift
//  pilot
//
//  Created by Nick Eckert on 10/15/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation
import ObjectMapper
import SafariServices

// Stores information from a /oauthUrl call to Lightning

struct OAuthRequest: Fetchable, Mappable {

  var url: String?
  var requestToken: String?
  var requestSecret: String?

  init?(map: Map) { }

  mutating func mapping(map: Map) {
    url <- map["url"]
    requestToken <- map["requestToken"]
    requestSecret <- map["requestSecret"]
  }

}
