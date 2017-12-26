//
//  UIIMage+Pilot.swift
//  pilot
//
//  Created by Nick Eckert on 11/26/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {

  class func resizeImageWithWidth(image: UIImage, width: CGFloat) -> UIImage {
    let oldWidth = image.size.width
    let scaleFactor = width / oldWidth

    let newHeight = image.size.height * scaleFactor
    let newWidth = oldWidth * scaleFactor

    // Draw the new image
    UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
    image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return newImage!
  }

}
