//
//  PilotUserViewModel.swift
//  pilot
//
//  Created by Nick Eckert on 7/24/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation

struct PilotUserViewModel {
    
    var pilotUser: PilotUser
    var userPlatforms = [PlatformViewModel]()
    
    var email: String {
        get {
            return pilotUser.email
        }
        
        set(newEmail) {
            pilotUser.email = newEmail
        }
    }
    
    var password: String {
        get {
            return pilotUser.password
        }
        
        set(newPassword) {
            pilotUser.password = newPassword
        }
    }
    
    var facebookAccessToken: String {
        get {
            return pilotUser.facebookAccessToken
        }
        
        set(newFacebookAccessToken) {
            pilotUser.facebookAccessToken = newFacebookAccessToken
        }
    }
    
    var twitterAccessToken: String {
        get {
            return pilotUser.twitterAccessToken
        }
        
        set(newTwitterAccessToken) {
            pilotUser.twitterAccessToken = newTwitterAccessToken
        }
    }
    
    var twitterAccessSecret: String {
        return pilotUser.twitterAccessSecret
    }
    
    init(pilotUser: PilotUser) {
        self.pilotUser = pilotUser
        
        userPlatforms = pilotUser.loadPlatforms()
    }
    
}
