//
//  Post.swift
//  pilot
//
//  Created by Nick Eckert on 8/9/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import UIKit
import Foundation
import ObjectMapper

// Represents data that a user wishes to upload to a platform
struct Post: Equatable, Publishable {
  
  var text = ""                    // Default empty string
  var thumbNailImage: UIImage?     // Image displayed to the user that will be uploaded
  var fileURL: URL?                // URL of the image or video to be uploaded
  var postType = PostType.text     // Type of data being uploaded (photo or video). Default text unless image is chosen.
  
}

func == (left: Post, right: Post) -> Bool {
  return left.text.hashValue
    == right.text.hashValue && left.thumbNailImage?.hashValue
    == right.thumbNailImage?.hashValue
}
