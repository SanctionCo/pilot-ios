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
          let actionSheet = UIAlertController(title: "Disconnect" + type.rawValue,
                                              message:
                                              """
                                                Are you sure you want to disconnect this account?
                                                You will need to reconnect again if you want post
                                                to this account in the future
                                              """,
                                              preferredStyle: UIAlertControllerStyle.actionSheet)

          actionSheet.addAction(UIAlertAction(title: "Disconnect", style: UIAlertActionStyle.default, handler: { _ in
            PlatformManager.sharedInstance.disconnectPlatform(type: type, onSuccess: {

              PlatformManager.sharedInstance.reload()

              // Alert the user that the platform removal was successful
              let alert = UIAlertController(title: "Account succesfully removed!",
                                            message: "", preferredStyle: .alert)

              alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                  self.navigationController?.popViewController(animated: true)
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

}
