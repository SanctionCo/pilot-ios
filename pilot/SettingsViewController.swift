//
//  SettingsViewController.swift
//  pilot
//
//  Created by Nick Eckert on 9/24/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var pilotUser: PilotUser = PilotUser(email: UserManager.sharedInstance!.getEmail(), password: UserManager.sharedInstance!.getPassword())
    var connectedPlatforms: [Platform] = []
    var unconnectedPlatforms: [Platform] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        
        styleUI()
        loadUI()
    }
    
    func styleUI() { }
    func loadUI() {
        connectedPlatforms = PlatformManager.sharedInstance.fetchConnectedPlatforms()
        unconnectedPlatforms = PlatformManager.sharedInstance.fetchUnconnectedPlatforms()
    }

}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AccountTableViewCell", for: indexPath) as! AccountTableViewCell
            cell.pilotUser = pilotUser
            
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ConnectionTableViewCell", for: indexPath) as! ConnectionTableViewCell
            
            if connectedPlatforms.count != 0 {
                cell.platform = connectedPlatforms[indexPath.row]
            } else {
                cell.platform = unconnectedPlatforms[indexPath.row]
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ConnectionTableViewCell", for: indexPath) as! ConnectionTableViewCell
            cell.platform = unconnectedPlatforms[indexPath.row]
            
            return cell
        }
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return ""
        } else if section == 1 {
            if connectedPlatforms.count != 0 {
                return "ConnectedAccounts"
            } else {
                return "Available Platforms"
            }
        } else {
            return "Available Platforms"
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let connectedCount = connectedPlatforms.count
        let unconnectedCount = unconnectedPlatforms.count
        
        if connectedCount == 0 && unconnectedCount == 0 {
            return 1
        } else if connectedCount != 0 && unconnectedCount != 0 {
            return 3
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            if connectedPlatforms.count != 0 {
                return connectedPlatforms.count
            } else {
                return unconnectedPlatforms.count
            }
        } else {
            return unconnectedPlatforms.count
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            let profileViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            
            self.navigationController?.pushViewController(profileViewController, animated: true)
        } else if indexPath.section == 1 {
            let accountViewController = self.storyboard?.instantiateViewController(withIdentifier: "AccountViewController") as! AccountViewController
            if connectedPlatforms.count != 0 {
                accountViewController.platform = connectedPlatforms[indexPath.row]
            } else {
                accountViewController.platform = unconnectedPlatforms[indexPath.row]
            }
            
            self.navigationController?.pushViewController(accountViewController, animated: true)
        } else if indexPath.section == 2 {
            let accountViewController = self.storyboard?.instantiateViewController(withIdentifier: "AccountViewController") as! AccountViewController
            accountViewController.platform = unconnectedPlatforms[indexPath.row]
            
            self.navigationController?.pushViewController(accountViewController, animated: true)
        }
        
    }
    
}
