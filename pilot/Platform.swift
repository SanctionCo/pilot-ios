//
//  Platform.swift
//  pilot
//
//  Created by Nick Eckert on 7/26/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation
import UIKit

struct Platform: PlatformProtocol {
  
  var type: PlatformType      // Enum type for the platform
  var image: UIImage?         // Image to represent the platform
  var isConnected: Bool       // Is the platform connected to the users account?
  var isSelected: Bool        // Is the platform selected by the user?
  
  var redirectURL: String {
    switch type {
    case .facebook:
      return PilotConfiguration.Lightning.facebookRedirectURL
    case .twitter:
      return PilotConfiguration.Lightning.twitterRedirectURL
    }
  }
  
  var tokenParamKey: String {
    switch type {
    case .facebook:
      return PilotConfiguration.Lightning.facebookTokenParamKey
    case .twitter:
      return PilotConfiguration.Lightning.twitterTokenParamKey
    }
  }
  
  init(type: PlatformType, isConnected: Bool) {
    self.type = type
    self.isConnected = isConnected
    self.isSelected = false  // Default
    
    self.setPlatformImage()
  }
  
  // Sets the image used to represent the platform
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
  
}

extension Platform: Hashable {
  var hashValue: Int {
    return type.hashValue &* 987654433
  }
}

extension Platform: Equatable { }

func == (left: Platform, right: Platform) -> Bool {
  guard left.hashValue == right.hashValue else { return false }
  return left.type == right.type
}
