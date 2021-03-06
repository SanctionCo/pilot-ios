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

  var verified: Bool?
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
    if (map.JSON["facebookAccessToken"] as? String) != nil {
      availablePlatforms.append(Platform(type: .facebook, isConnected: true))
    } else {
      availablePlatforms.append(Platform(type: .facebook, isConnected: false))
    }

    if (map.JSON["twitterAccessToken"] as? String) != nil {
      availablePlatforms.append(Platform(type: .twitter, isConnected: true))
    } else {
      availablePlatforms.append(Platform(type: .twitter, isConnected: false))
    }
  }

  mutating func mapping(map: Map) {
    verified            <- map["email.verified"]
    email               <- map["email.address"]
    password            <- map["password"]
    facebookAccessToken <- map["facebookAccessToken"]
    twitterAccessToken  <- map["twitterAccessToken"]
    twitterAccessSecret <- map["twitterAccessSecret"]
  }

}
