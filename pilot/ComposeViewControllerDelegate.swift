//
//  ComposeViewControllerDelegate.swift
//  pilot
//
//  Created by Nick Eckert on 11/25/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation
import UIKit

protocol ComposeViewControllerDelegate: NSObjectProtocol {

  func didUpdateText(text: String)
  func didUpdateImage(image: UIImage)
  func didUpdateVideo(video: URL)
  func didUpdateType(type: PostType)

}
