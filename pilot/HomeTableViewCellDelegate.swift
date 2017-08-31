//
//  HomeTableViewCellDelegate.swift
//  pilot
//
//  Created by Nick Eckert on 8/14/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation

// Allows communication back to the platforms cell view

protocol HomeTableViewCellDelegate {
    
    func setProgress(value: Double) -> ()
    func showProgressBar() -> ()
    func hideProgressBar() -> ()
    
}
