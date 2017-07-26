//
//  PilotUserViewModel.swift
//  pilot
//
//  Created by Nick Eckert on 7/24/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation

struct PilotUserViewModel {
    
    var pilotUser: PilotUser!
    
    var email: String {
        return pilotUser.email
    }
    
    var password: String {
        return pilotUser.password
    }
    
    var facebookAccessToken: String {
        return pilotUser.facebookAccessToken
    }
    
    var twitterAccessToken: String {
        return pilotUser.twitterAccessToken
    }
    
    var twitterAccessSecret: String {
        return pilotUser.twitterAccessSecret
    }
    
    init(pilotUser: PilotUser) {
        self.pilotUser = pilotUser
    }
    
}
