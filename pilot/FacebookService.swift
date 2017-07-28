//
//  FacebookService.swift
//  pilot
//
//  Created by Nick Eckert on 7/24/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class FacebookService: FileService {
    let photosEndpoint = PilotConfiguration.Lightning.endpoint + "/facebook/photos"
    let videosEndpoint = PilotConfiguration.Lightning.endpoint + "/facebook/videos"
    
    var pilotUser: PilotUser!
    
    internal var basicCredentials: String
    
    required init(pilotUser: PilotUser) {
        self.pilotUser = pilotUser
        
        basicCredentials = "\(PilotConfiguration.Lightning.userKey):\(PilotConfiguration.Lightning.userSecret)"
            .data(using: String.Encoding.utf8)!.base64EncodedString(options: [])
    }
    
}
