//
//  Post.swift
//  pilot
//
//  Created by Nick Eckert on 8/9/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation
import ObjectMapper
import UIKit

// Represents data that a user wishes to upload to a platform
struct Post: Equatable, Publishable {

  var delegate: ComposeViewControllerDelegate?

  var text: String?                // Text associated with the post.
  var image: UIImage?              // Image associated with the post.
  var video: URL?                  // URL of the video to be uploaded.
  var type = PostType.text         // Type of data being uploaded (photo or video). Default text unless image is chosen.

  mutating func updateText(text: String) {
    self.text = text

    delegate?.didUpdateText(text: text)
  }

  mutating func updateImage(image: UIImage) {
    self.image = image

    delegate?.didUpdateImage(image: image)
  }

  mutating func updateVideo(video: URL) {
    self.video = video

    delegate?.didUpdateVideo(video: video)
  }

  mutating func updateType(type: PostType) {
    self.type = type

    delegate?.didUpdateType(type: type)
  }
}

func == (left: Post, right: Post) -> Bool {
  return left.text?.hashValue == right.text?.hashValue
      && left.image?.hashValue == right.image?.hashValue
}
