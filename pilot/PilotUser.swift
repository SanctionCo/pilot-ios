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
    
    let email: String!
    let password: String!
    let facebookAccessToken: String!
    let twitterAccessToken: String!
    let twitterAccessSecret: String!
    
    init(email: String, password: String, facebookAccessToken: String, twitterAccessToken: String, twitterAccessSecret: String) {
        self.email = email
        self.password = password
        self.facebookAccessToken = facebookAccessToken
        self.twitterAccessToken = twitterAccessToken
        self.twitterAccessSecret = twitterAccessSecret
    }
    
}
