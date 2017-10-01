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
    
}
