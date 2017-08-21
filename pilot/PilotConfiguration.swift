//
//  PilotConfiguration.swift
//  pilot
//
//  Created by Nick Eckert on 7/25/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation

struct PilotConfiguration {
    
    struct Thunder {
        static let endpoint = "http://thunder.sanctionco.com"
        static let userKey = "lightning"
        static let userSecret = "secret"
    }
    
    struct Lightning {
        static let endpoint = "http://lightning.sanctionco.com"
        static let userKey = "application"
        static let userSecret = "secret"
    }
    
}
