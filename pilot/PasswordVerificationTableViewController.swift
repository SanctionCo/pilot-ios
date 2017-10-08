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

  @IBOutlet weak var passwordField: UITextField!
  @IBOutlet weak var done: UIBarButtonItem!

  override func viewDidLoad() {
      super.viewDidLoad()

  }

  @IBAction func cancel(_ sender: UIBarButtonItem) {
    self.dismiss(animated: true, completion: nil)
  }

  @IBAction func done(_ sender: UIBarButtonItem) {

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
