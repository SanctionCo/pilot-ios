//
//  SelectionTableViewModel.swift
//  pilot
//
//  Created by Nick Eckert on 7/26/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation
import UIKit

struct PlatformViewModel: Hashable {
    
    var platform: Platform!
    
    var hashValue: Int {
        return platform.type.hashValue
    }
    
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
    
    func publish(text: String?, image: UIImage?) {
        guard let platform = platform else {
            return
        }
        
        switch platform.type {
        case .facebook:
            break
        case .twitter:
            break
        }
    }
    
    static func ==(lhs: PlatformViewModel, rhs: PlatformViewModel) -> Bool {
        return lhs.platform.type == rhs.platform.type
    }
    
}
