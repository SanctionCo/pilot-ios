//
//  ComposeViewControllerDelegate.swift
//  pilot
//
//  Created by Nick Eckert on 11/25/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation
import UIKit

protocol ComposeViewControllerDelegate {

  func didUpdateText(text: String) -> Void
  func didUpdateImage(image: UIImage) -> Void
  func didUpdateVideo(video: URL) -> Void
  func didUpdateType(type: PostType) -> Void

}
