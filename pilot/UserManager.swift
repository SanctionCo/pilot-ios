//
//  UserManager.swift
//  pilot
//
//  Created by Nick Eckert on 9/27/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation

class UserManager {
    
    static var sharedInstance: UserManager?
    
    fileprivate var pilotUser: PilotUser
    
    init(pilotUser: PilotUser) {
        self.pilotUser = pilotUser
    }
    
    func getEmail() -> String {
        return pilotUser.email!
    }
    
    func getPassword() -> String {
        return pilotUser.password!
    }
    
    func getFacebookAccessToken() -> String {
        return pilotUser.facebookAccessToken!
    }
    
    func getTwitterAccessToken() -> String {
        return pilotUser.twitterAccessToken!
    }
    
    func getTwitterAccessSecret() -> String {
        return pilotUser.twitterAccessSecret!
    }
    
    func setEmail(newEmail: String) {
        self.pilotUser.email = newEmail
    }
    
    func setPassword(newPassword: String) {
        self.pilotUser.password = newPassword
    }
    
    func setFacebookAccessToken(token: String) {
        self.pilotUser.facebookAccessToken = token
    }
    
    func setTwitterAccessToken(token: String) {
        self.pilotUser.twitterAccessToken = token
    }
    
    func setTwitterAccessSecret(secret: String) {
        self.pilotUser.twitterAccessSecret = secret
    }
    
}
