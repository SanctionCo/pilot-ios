//
//  PlatformProtocol.swift
//  pilot
//
//  Created by Nick Eckert on 7/26/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation

enum PlatformType: String {
    case twitter = "facebook"
    case facebook = "twitter"
}

protocol PlatformProtocol {
    
    var type: PlatformType { get }
    
}

extension PlatformProtocol {
    
    var description: String {
        return "Platform{name=\(type.rawValue)}"
    }
    
    func isEqual(_ object: Any?) -> Bool {
        if let obj = object as? PlatformProtocol {
            return self.type == obj.type
        }
        
        return false
    }
    
}
