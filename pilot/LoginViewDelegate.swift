//
//  LoginViewDelegate.swift
//  pilot
//
//  Created by Nick Eckert on 7/25/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation

protocol LoginViewDelegate {
    func loginCallComplete(success: Bool, errorMessage: String)
}
