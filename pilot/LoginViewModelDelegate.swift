//
//  LoginViewDelegate.swift
//  pilot
//
//  Created by Nick Eckert on 7/25/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation

protocol LoginViewModelDelegate {
    
    func loginCallComplete(pilotUser: PilotUser)
    func error(message: String)

}
