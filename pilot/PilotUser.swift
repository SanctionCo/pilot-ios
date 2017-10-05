//
//  PilotUser.swift
//  pilot
//
//  Created by Nick Eckert on 7/24/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation
import ObjectMapper

// Represents a pilot user fetched from thunder

struct PilotUser: Fetchable, Uploadable, Deletable, Mappable {

  var email: String?
  var password: String?
  var facebookAccessToken: String?
  var twitterAccessToken: String?
  var twitterAccessSecret: String?

  var availablePlatforms = [Platform]()  // List of platforms the user has

  init(email: String, password: String) {
    self.email = email
    self.password = password
  }

  init?(map: Map) {

    if let _ = map.JSON["facebookAccessToken"] as? String {
      availablePlatforms.append(Platform(type: .facebook, isConnected: true))
    } else {
      availablePlatforms.append(Platform(type: .facebook, isConnected: false))
    }

    if let _ = map.JSON["twitterAccessToken"] as? String {
      availablePlatforms.append(Platform(type: .twitter, isConnected: true))
    } else {
      availablePlatforms.append(Platform(type: .twitter, isConnected: false))
    }

  }

  mutating func mapping(map: Map) {
    email <- map["email"]
    password <- map["password"]
    facebookAccessToken <- map["facebookAccessToken"]
    twitterAccessToken <- map["twitterAccessToken"]
    twitterAccessSecret <- map["twitterAccessSecret"]
  }

}
