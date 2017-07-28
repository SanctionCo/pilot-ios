//
//  ComposeViewModel.swift
//  pilot
//
//  Created by Nick Eckert on 7/26/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation
import UIKit

struct ComposeViewModel {
    
    var pilotUser: PilotUser
    var delegate: ComposeViewModelDelegate?
    
    var userPlatforms: [PlatformViewModel] = []
    
    init(pilotUser: PilotUser) {
        self.pilotUser = pilotUser
        
        loadPlatforms()
    }
    
    var chosenImage: UIImage? {
        didSet {
            delegate?.didSetImage(image: chosenImage!)
        }
    }
    
    mutating func loadPlatforms() {

        if !pilotUser.facebookAccessToken.isEmpty {
            userPlatforms.append(PlatformViewModel(platform: PilotConfiguration.Platforms.facebook))
        }
        
        if !pilotUser.twitterAccessToken.isEmpty {
            userPlatforms.append(PlatformViewModel(platform: PilotConfiguration.Platforms.twitter))
        }
        
    }
    
    func publish(text: String?, image: UIImage?, platforms: [PlatformViewModel]) {
        
        // Validate that a service is chosen and the text and image fields are not empty
        guard let text = text, let image = image else {
            delegate?.error(message: "Cannot have empty post message or unchosen image")
            
            return
        }
        
        // Publish from here
    }
    
    func platformsToChoose() -> [PlatformViewModel] {
        let allPlatforms = PilotConfiguration.Platforms.allPlatforms()
        return Array(Set(allPlatforms).subtracting(userPlatforms))
    }
    
}
