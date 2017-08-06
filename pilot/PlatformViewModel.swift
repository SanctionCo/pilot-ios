//
//  SelectionTableViewModel.swift
//  pilot
//
//  Created by Nick Eckert on 7/26/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation
import UIKit

struct PlatformViewModel {
    
    var platform: Platform
    var delegate: PlatformViewModelDelegate?
    
    var name: String {
        let type = platform.type
        return type.rawValue
    }
    
    var image: UIImage? {
        return platform.image
    }
    
    init(platform: Platform) {
        self.platform = platform
    }
    
    mutating func setPlatformImage() {
        switch platform.type {
        case PlatformType.facebook:
            guard let facebookImage = UIImage(named: "facebook") else {
                return
            }
            
            platform.image = facebookImage
        case PlatformType.twitter:
            guard let twitterImage = UIImage(named: "twitter") else {
                return
            }
            
            platform.image = twitterImage
        }
    }
}

