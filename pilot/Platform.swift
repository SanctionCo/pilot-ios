//
//  Platform.swift
//  pilot
//
//  Created by Nick Eckert on 7/26/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation
import UIKit

struct Platform: PlatformProtocol, Hashable {
    
    var type: PlatformType
    var image: UIImage?
    var hashValue: Int {
        return type.hashValue
    }
    
    init(type: PlatformType) {
        self.type = type
        
        setPlatformImage()
    }
    
    mutating func setPlatformImage() {
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
    
    static func ==(lhs: Platform, rhs: Platform) -> Bool {
        return lhs.type == rhs.type
    }
    
}
