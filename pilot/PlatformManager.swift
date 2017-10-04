//
//  PlatformManager.swift
//  pilot
//
//  Created by Nick Eckert on 9/23/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation

// Keep track of all platforms and their state

class PlatformManager {
    
    static var sharedInstance = PlatformManager()
    
    fileprivate var platforms: [Platform] = []
    
    func fetchConnectedPlatforms() -> [Platform] {
        
        var connectedPlatforms: [Platform] = []
        for platform in platforms {
            if platform.isConnected {
                connectedPlatforms.append(platform)
            }
        }
        
        return connectedPlatforms
    }
    
    func fetchUnconnectedPlatforms() -> [Platform] {
        
        var unconnectedPlatforms: [Platform] = []
        for platform in platforms {
            if !platform.isConnected {
                unconnectedPlatforms.append(platform)
            }
        }
        
        return unconnectedPlatforms
    }
    
    func setPlatforms(platforms: [Platform]) {
        self.platforms = platforms
    }
    
    // Update the platform list using the local pilotUser stored in UserManager
    func reload() {
        
        if let manager = UserManager.sharedInstance {
            self.platforms = manager.getAvailablePlatforms()
        }
        
    }
    
    typealias SuccessHandler = () -> Void
    typealias ErrorHandler = (Error) -> Void
    
    /// Disconnects a platform from the logged in user
    ///
    /// - Parameter type: A platform type to disconnect
    func disconnectPlatform(type: PlatformType, onSuccess: @escaping SuccessHandler, onError: @escaping ErrorHandler) {
        
        guard let sharedInstance = UserManager.sharedInstance else {
            return
        }
        
        switch type {
        case .facebook:
            sharedInstance.setFacebookAccessToken(token: nil)
        case .twitter:
            sharedInstance.setTwitterAccessToken(token: nil)
            sharedInstance.setTwitterAccessSecret(secret: nil)
        }
                
        sharedInstance.updateUser(onSuccess: { _ in
            onSuccess()
        }, onError: { error in
            onError(error)
        })
    }
    
}
