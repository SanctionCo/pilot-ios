//
//  ComposeViewModel.swift
//  pilot
//
//  Created by Nick Eckert on 7/26/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation
import UIKit

struct HomeViewModel {
    
    // Models
    var pilotUser: PilotUser
    
    // Delegate
    var delegate: HomeViewModelDelegate?
    
    //var userPlatforms: [Platform]
    
    init(pilotUser: PilotUser) {
        self.pilotUser = pilotUser
    }
    
    /// Upload data to provided destination platroms
    ///
    /// - Parameters:
    ///   - text: User text
    ///   - image: User selected image
    ///   - platforms: List of destination platforms
    func publish(text: String?, image: UIImage?, platforms: [PlatformViewModel]) {
        
        // Validate that at least one field is not empty
        if text == nil && image == nil {
            delegate?.error(message: "You must have at least one field to publish!")
        }
        
    }
    
}
