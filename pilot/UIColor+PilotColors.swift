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
    
    static let PilotBlue = UIColor.fromRGB(red: 114.0, green: 192.0, blue: 228.0)
    static let PilotBrownBackground = UIColor.fromRGB(red: 242.0, green: 242.0, blue: 242.0)
    static let PilotBrownText = UIColor.fromRGB(red: 173.0, green: 173.0, blue: 173.0)
    static let ErrorRed = UIColor.fromRGB(red: 242, green: 71, blue: 15)
    static let White = UIColor.fromRGB(red: 255, green: 255, blue: 255)
    
    // Returns color instance from RGB values (0-255)
    static func fromRGB(red: Double, green: Double, blue: Double, alpha: Double = 100.0) -> UIColor {
        let rgbRed = CGFloat(red/255)
        let rgbGreen = CGFloat(green/255)
        let rgbBlue = CGFloat(blue/255)
        let rgbAlpha = CGFloat(alpha/100)
        
        return UIColor(red: rgbRed, green: rgbGreen, blue: rgbBlue, alpha: rgbAlpha)
    }
    
}
