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

struct PilotUser: Fetchable, Mappable {
    
    var email: String?
    var password: String?
    var facebookAccessToken: String?
    var twitterAccessToken: String?
    var twitterAccessSecret: String?
    
    var availablePlatforms = [Platform]()  // List of the platforms the user has
    
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

extension PilotUser {
    
//    var description: String {
//        return "PilotUser {email=\(email))}"
//    }
//
//    func isEqual(_ object: Any?) -> Bool {
//        if let obj = object as? PilotUser {
//            return self.type == obj.type
//        }
//        
//        return false
//    }
    
}
