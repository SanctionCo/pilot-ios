//
//  OAuthResult.swift
//  pilot
//
//  Created by Nick Eckert on 10/21/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation
import ObjectMapper

struct OAuthResult: Fetchable, Mappable {

  var accessToken: String?
  var accessSecret: String?

  init(accessToken: String?, accessSecret: String?) {
    self.accessToken = accessToken
    self.accessSecret = accessSecret
  }

  init?(map: Map) { }

  mutating func mapping(map: Map) {
    accessToken <- map["accessToken"]
    accessSecret <- map["accessSecret"]
  }

}
