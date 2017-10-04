//
//  AuthToken.swift
//  pilot
//
//  Created by Nick Eckert on 8/21/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation
import SwiftHash

// The Auth Token is used for headers or parameters needed to authenticate a request

struct AuthToken {
  
  var email: String
  var password: String
  
  init(email: String, password: String) {
    self.email = email
    self.password = password
  }
  
}
