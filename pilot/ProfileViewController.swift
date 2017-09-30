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
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                
            }
            if indexPath.row == 1 {
                
            }
        }
        
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                UserManager.sharedInstance?.invalidateUser()
                
                // Navigate back to the LoginViewController
                let storyboard = UIStoryboard.init(name: "LoginViewController", bundle: nil)
                let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                
                self.present(loginViewController, animated: false, completion: nil)
            }
        }
    }
}