//
//  UIColor+PilotColors.swift
//  pilot
//
//  Created by Nick Eckert on 7/25/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
  
  // UI Colors
  static let PilotBlue = UIColor.fromRGB(red: 1.0, green: 126.0, blue: 185.0)
  
  // Button Colors
  static let ButtonRed = UIColor.fromRGB(red: 215, green: 46, blue: 46)
  static let ButtonBlue = UIColor.fromRGB(red: 55, green: 139, blue: 251)
  
  // Text Colors
  static let TextBrown = UIColor.fromRGB(red: 173.0, green: 173.0, blue: 173.0)
  static let TextRed = UIColor.fromRGB(red: 242, green: 71, blue: 15)
  static let TextGray = UIColor.fromRGB(red: 154, green: 154, blue: 154)
  static let TextWhite = UIColor.fromRGB(red: 255, green: 255, blue: 255)
  static let TextBlack = UIColor.fromRGB(red: 0, green: 0, blue: 0)
  
  // Returns color instance from RGB values (0-255)
  static func fromRGB(red: Double, green: Double, blue: Double, alpha: Double = 100.0) -> UIColor {
    let rgbRed = CGFloat(red/255)
    let rgbGreen = CGFloat(green/255)
    let rgbBlue = CGFloat(blue/255)
    let rgbAlpha = CGFloat(alpha/100)
    
    return UIColor(red: rgbRed, green: rgbGreen, blue: rgbBlue, alpha: rgbAlpha)
  }
  
}
