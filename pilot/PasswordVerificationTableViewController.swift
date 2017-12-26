//
//  PasswordVerificationTableViewController.swift
//  pilot
//
//  Created by Nick Eckert on 10/8/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import SwiftHash
import UIKit

class PasswordVerificationTableViewController: UITableViewController {

  var passwordField: UITextField = {
    let field = UITextField()
    field.translatesAutoresizingMaskIntoConstraints = false
    return field
  }()

  var doneButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  override func viewDidLoad() {
      super.viewDidLoad()
  }

  func cancel(_ sender: UIBarButtonItem) {
    self.dismiss(animated: true, completion: nil)
  }

  func done(_ sender: UIBarButtonItem) {
    guard let passwordFieldText = passwordField.text else {
      return
    }

    let hashedPassword = MD5(passwordFieldText).lowercased()
    if hashedPassword == UserManager.sharedInstance?.getPassword() {
      if let navNewPasswordController =
        self.storyboard?.instantiateViewController(withIdentifier: "NewPasswordTableViewController")
          as? NewPasswordTableViewController {

        self.navigationController?.pushViewController(navNewPasswordController, animated: true)
      }
    } else {
      let alert = UIAlertController(title: "Incorrect password",
                                    message: "The password you entered was incorrect, please try again.",
                                    preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      present(alert, animated: true, completion: nil)
    }
  }
}
