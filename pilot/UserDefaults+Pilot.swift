//
//  UserDefaults+Pilot.swift
//  pilot
//
//  Created by Rohan Nagar on 1/16/18.
//  Copyright © 2018 sanction. All rights reserved.
//

import Foundation

extension UserDefaults {
  func contains(key: String) -> Bool {
    return UserDefaults.standard.object(forKey: key) != nil
  }
}
