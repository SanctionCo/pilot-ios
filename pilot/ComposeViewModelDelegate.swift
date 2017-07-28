//
//  ComposeViewModelDelegate.swift
//  pilot
//
//  Created by Nick Eckert on 7/26/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation
import UIKit

protocol ComposeViewModelDelegate {
    func didSetImage(image: UIImage)
    func error(message: String)
}
