//
//  PlatformListViewModel.swift
//  pilot
//
//  Created by Nick Eckert on 7/26/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation

struct PlatformListViewModel {
    
    var platformList: [PlatformViewModel]
    
    init(platformList: [PlatformViewModel]) {
        self.platformList = platformList
    }
    
}
