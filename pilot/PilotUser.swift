//
//  PilotUser.swift
//  pilot
//
//  Created by Nick Eckert on 7/24/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation

// Represents a pilot user fetched from thunder

struct PilotUser {
    
    var email: String!
    var password: String!
    var facebookAccessToken: String!
    var twitterAccessToken: String!
    var twitterAccessSecret: String!
    
    init(email: String, password: String, facebookAccessToken: String, twitterAccessToken: String, twitterAccessSecret: String) {
        self.email = email
        self.password = password
        self.facebookAccessToken = facebookAccessToken
        self.twitterAccessToken = twitterAccessToken
        self.twitterAccessSecret = twitterAccessSecret
    }
    
    func loadPlatforms() -> [Platform] {
        var platforms = [Platform]()
        
        if !facebookAccessToken.isEmpty {
            platforms.append(PilotConfiguration.Platforms.facebook)
        }
        
        if !twitterAccessToken.isEmpty {
            platforms.append(PilotConfiguration.Platforms.twitter)
        }
        
        return platforms
    }
    
}
