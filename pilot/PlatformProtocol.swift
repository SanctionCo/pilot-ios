//
//  PlatformProtocol.swift
//  pilot
//
//  Created by Nick Eckert on 7/26/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Alamofire
import Foundation
import HTTPStatusCodes

enum PlatformType: String {
  case twitter = "Twitter"
  case facebook = "Facebook"
}

protocol PlatformProtocol {

  var type: PlatformType { get }
  var image: UIImage? { get set }
  var isConnected: Bool { get set }

}
