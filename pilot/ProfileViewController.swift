//
//  ProfileViewController.swift
//  pilot
//
//  Created by Nick Eckert on 9/29/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.largeTitleDisplayMode = .never
        
        let customHeaderView = Bundle.main.loadNibNamed("CustomTableHeaderView", owner: self, options: nil)?.first as! UIView
        self.tableView.tableHeaderView = customHeaderView
    }
    
}
