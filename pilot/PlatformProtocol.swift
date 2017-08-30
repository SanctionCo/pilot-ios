//
//  PlatformProtocol.swift
//  pilot
//
//  Created by Nick Eckert on 7/26/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import HTTPStatusCodes

enum PlatformType: String {
    case twitter = "twitter"
    case facebook = "facebook"
}

protocol PlatformProtocol {
    
    var type: PlatformType { get }
    var selected: Bool { get set }
    var image: UIImage? { get set }
        
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
