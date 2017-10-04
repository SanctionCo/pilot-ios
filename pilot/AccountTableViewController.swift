//
//  AccountTableViewController.swift
//  pilot
//
//  Created by Nick Eckert on 10/3/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import UIKit

class AccountTableViewController: UITableViewController {
    
    var platform: Platform?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let title = platform?.type.rawValue {
            self.title = title
        }
        
        navigationItem.largeTitleDisplayMode = .never
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                
                if let type = self.platform?.type {
                    PlatformManager.sharedInstance.disconnectPlatform(type: type, onSuccess: {
                        
                        PlatformManager.sharedInstance.reload()
                        
                        self.navigationController?.popViewController(animated: true)
                    }, onError: { error in
                        debugPrint(error)
                    })
                }
                
            }
        }
        
    }
    
}
