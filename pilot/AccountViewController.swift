//
//  AccountViewController.swift
//  pilot
//
//  Created by Nick Eckert on 9/26/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    
    var platform: Platform?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let title = platform?.type.rawValue {
            self.title = title
        }
        
        navigationItem.largeTitleDisplayMode = .never
    }

}
