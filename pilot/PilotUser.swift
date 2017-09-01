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

struct PilotUser: Fetchable, Uploadable, Mappable {
    
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
    
        if let facebookAccessToken = map.JSON["facebookAccessToken"] as? String {
            if !facebookAccessToken.isEmpty {
                availablePlatforms.append(Platform(type: .facebook))
            }
        }
        
        if let twitterAccessToken = map.JSON["twitterAccessToken"] as? String {
            if !twitterAccessToken.isEmpty {
                availablePlatforms.append(Platform(type: .twitter))
            }
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
