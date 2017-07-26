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
    
    var delegate: LoginViewDelegate!
    
    let pilotUserService = PilotUserService()
    
    func login(email: String?, password: String?) {
        
        guard let email = email, let password = password else {
            // Display an error here
            
            return
        }
        
        if validate(email: email, password: password) {
            let hashedPassword = MD5(password).lowercased()

            pilotUserService.getPilotUser(email, password: hashedPassword, completion: { pilotUser in
                self.delegate?.loginCallComplete(success: true, errorMessage: "")
            }, failure: { httpStatusCode in
                self.delegate?.loginCallComplete(success: false, errorMessage: httpStatusCode.description)
            })
        }
    }
    
    fileprivate func validate(email: String, password: String) -> Bool {
        
        if email.isEmpty || password.isEmpty {
            delegate?.loginCallComplete(success: false, errorMessage: "Cannot have empty fields")
            
            return false
        }
        
        return true
    }
    
}
