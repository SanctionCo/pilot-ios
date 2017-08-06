//
//  LoginUserViewModel.swift
//  pilot
//
//  Created by Nick Eckert on 7/25/17.
//  Copyright © 2017 sanction. All rights reserved.
//

// Business logic for logging in

import Foundation

import HTTPStatusCodes
import SwiftHash

struct LoginViewModel {
    
    var delegate: LoginViewModelDelegate?
    
    let pilotUserService = PilotUserService()
    
    /// Logs a user in using and email and password
    ///
    /// - Parameters:
    ///   - email: email associated with a user account
    ///   - password: password associated with a user account
    func login(email: String?, password: String?) {
        
        guard let delegate = delegate, let email = email, let password = password else { return }
        
        if validate(email: email, password: password) {
            let hashedPassword = MD5(password).lowercased()

            pilotUserService.getPilotUser(email, password: hashedPassword, completion: { pilotUser in
                delegate.loginCallComplete(pilotUser: pilotUser)
            }, failure: { httpStatusCode in
                delegate.error(message: httpStatusCode.description)
            })
        }
    }
    
    /// Validates that a user email and password are not empty or of invalid format
    ///
    /// - Parameters:
    ///   - email: email associated with a user account
    ///   - password: password associated with a user account
    /// - Returns: wether or not the email or password are valid
    fileprivate func validate(email: String, password: String) -> Bool {
        
        if email.isEmpty || password.isEmpty {
            delegate?.error(message: "Cannot have empty fields")
            
            return false
        }
        
        return true
    }
    
}
