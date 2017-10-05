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

    let customHeaderView =
      Bundle.main.loadNibNamed("CustomTableHeaderView", owner: self, options: nil)?.first as! UIView
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

        let actionSheet = UIAlertController(title: "Sign out",
                                            message: "Are you sure you want to sign out?",
                                            preferredStyle: UIAlertControllerStyle.actionSheet)

        actionSheet.addAction(UIAlertAction(title: "Sign out", style: UIAlertActionStyle.default, handler: { _ in
          let storyboard = UIStoryboard.init(name: "LoginViewController", bundle: nil)
          let loginViewController =
            storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController

          self.present(loginViewController, animated: false, completion: nil)
        }))

        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))

        present(actionSheet, animated: true, completion: nil)
      }
    }
    
    if indexPath.section == 2 {
      if indexPath.row == 0 {
        let actionSheet = UIAlertController(title: "DELETE ACCOUNT",
                                            message: """
                                                      Are you sure you want to delete your account?
                                                      This action cannot be undone.
                                                     """,
                                            preferredStyle: UIAlertControllerStyle.actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Delete", style: UIAlertActionStyle.default, handler: { _ in
          
          UserManager.sharedInstance?.deleteUser(onSuccess: { _ in
            
            // Alert the user that the account was succesfully deleted
            let alert = UIAlertController(title: "User account succesfully deleted!",
                                          message: "", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
              
              // Navigate back to the LoginViewController
              let storyboard = UIStoryboard.init(name: "LoginViewController", bundle: nil)
              let loginViewController =
                storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
    
              self.present(loginViewController, animated: false, completion: nil)
            })
            
            self.present(alert, animated: true, completion: nil)
          }, onError: { error in
            debugPrint(error)
          })
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        present(actionSheet, animated: true, completion: nil)
      }
    }
  }
}
