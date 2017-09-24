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
    
    // Reload the platfrom list from Thunder
    func reload() {
        
        PilotUser.fetch(with: ThunderRouter.fetchPilotUser(), onSuccess: { [weak self] pilotUser in
            self?.platforms = pilotUser.availablePlatforms
        }, onError: { error in
            // Display an error to the user informing them their data is out of sync
            print("There was en error updaing the platform list")
        })
        
    }
    
}
