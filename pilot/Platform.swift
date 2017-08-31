//
//  Platform.swift
//  pilot
//
//  Created by Nick Eckert on 7/26/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation
import UIKit

// WARNING: Only one platform should exist per PlatformType otherwise you'll have multiple instances of each service! :o

class Platform: PlatformProtocol, Equatable {
    
    var type: PlatformType      // Enum type for the platform
    var selected: Bool          // If the user has selected this platform as an upload target
    var image: UIImage?         // Image to represent the platform
    
    var delegate: HomeTableViewCellDelegate? // Allows communication back to the cell view (Updating loading state)
    
    init(type: PlatformType) {
        self.type = type
        self.selected = false // TODO: Pull this from config file to persist across app restart
        
        setPlatformImage()
    }
    
    /// Sets the image used to represent the platform
    func setPlatformImage() {
        switch type {
        case PlatformType.facebook:
            guard let facebookImage = UIImage(named: "facebook") else {
                return
            }
            
            image = facebookImage
        case PlatformType.twitter:
            guard let twitterImage = UIImage(named: "twitter") else {
                return
            }
            
            image = twitterImage
        }
    }
    
}

func == (left: Platform, right: Platform) -> Bool {
    return left.type.hashValue == right.type.hashValue
}
