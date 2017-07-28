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
    
    var delegate: LoginViewModelDelegate!
    
    let pilotUserService = PilotUserService()
    var pilotUser: PilotUser!
    
    func login(email: String?, password: String?) {
        
        guard let email = email, let password = password else {
            // Display an error here
            
            return
        }
        
        if validate(email: email, password: password) {
            let hashedPassword = MD5(password).lowercased()

            pilotUserService.getPilotUser(email, password: hashedPassword, completion: { pilotUser in
                self.delegate?.loginCallComplete(pilotUser: pilotUser)
            }, failure: { httpStatusCode in
                self.delegate?.error(message: httpStatusCode.description)
            })
        }
    }
    
    fileprivate func validate(email: String, password: String) -> Bool {
        
        if email.isEmpty || password.isEmpty {
            delegate?.error(message: "Cannot have empty fields")
            
            return false
        }
        
        return true
    }
    
}
