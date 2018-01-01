//
//  ProfileViewController.swift
//  pilot
//
//  Created by Nick Eckert on 9/29/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

  var tableHeader: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  var profileTable: UITableView = {
    let table = UITableView(frame: CGRect.zero, style: .grouped)
    table.translatesAutoresizingMaskIntoConstraints = false
    return table
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    self.profileTable.delegate = self
    self.profileTable.dataSource = self

    self.profileTable.register(ProfilePasswordResetCell.self, forCellReuseIdentifier: "ProfilePasswordResetCell")
    self.profileTable.register(ProfileSignoutCell.self, forCellReuseIdentifier: "ProfileSignoutCell")
    self.profileTable.register(ProfileDeleteAccountCell.self, forCellReuseIdentifier: "ProfileDeleteAccountCell")

    self.navigationItem.largeTitleDisplayMode = .never

    self.view.addSubview(profileTable)

    setupProfileTable()
  }

  func setupProfileTable() {

    self.profileTable.addSubview(tableHeader)

    self.profileTable.tableHeaderView = tableHeader
    self.profileTable.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    self.profileTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    self.profileTable.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    self.profileTable.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
  }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {

  // MARK: TableViewDataSource

  func numberOfSections(in tableView: UITableView) -> Int {
    return 3
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.section {
    case 0: return ProfilePasswordResetCell()
    case 1: return ProfileSignoutCell()
    case 2: return ProfileDeleteAccountCell()
    default: fatalError("Unknown Section")
    }
  }

  // MARK: TableViewDelegate

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    // Change password
    if indexPath.section == 0 {
      if indexPath.row == 0 {
        let passwordVerificationController = PasswordVerificationTableViewController()
        let passwordVerificationNavigationController
          = UINavigationController(rootViewController: passwordVerificationController)

        self.present(passwordVerificationNavigationController, animated: true, completion: nil)
      }
    }

    // Sign out field
    if indexPath.section == 1 {
      if indexPath.row == 0 {
        let actionSheet = UIAlertController(title: "Sign out",
                                            message: "Are you sure you want to sign out?",
                                            preferredStyle: UIAlertControllerStyle.actionSheet)

        actionSheet.addAction(UIAlertAction(title: "Sign out", style: UIAlertActionStyle.default, handler: { _ in
          UserManager.sharedInstance?.invalidateUser()

          let storyboard = UIStoryboard.init(name: "LoginViewController", bundle: nil)

          if let loginViewController =
            storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {

            self.present(loginViewController, animated: false, completion: nil)
          }
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))

        present(actionSheet, animated: true, completion: nil)
      }
    }

    // Delete field
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

            // Alert the user that the account was successfully deleted
            let alert = UIAlertController(title: "User account successfully deleted!",
                                          message: "", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in

              // Navigate back to the LoginViewController
              let storyboard = UIStoryboard.init(name: "LoginViewController", bundle: nil)
              if let loginViewController =
                storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {

                self.present(loginViewController, animated: false, completion: nil)
              }
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
