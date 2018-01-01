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

    let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancel))
    let nextButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(self.done))

    self.navigationItem.rightBarButtonItem = nextButton
    self.navigationItem.leftBarButtonItem = cancelButton

    self.view.addSubview(passwordField)

    setupPasswordField()
  }

  @objc func cancel(_ sender: UIBarButtonItem) {
    self.dismiss(animated: true, completion: nil)
  }

  @objc func done(_ sender: UIBarButtonItem) {
    guard let passwordFieldText = passwordField.text else {
      return
    }

    let hashedPassword = MD5(passwordFieldText).lowercased()
    if hashedPassword == UserManager.sharedInstance?.getPassword() {
      let newPasswordController = NewPasswordTableViewController()
      self.navigationController?.pushViewController(newPasswordController, animated: true)
    } else {
      let alert = UIAlertController(title: "Incorrect password",
                                    message: "The password you entered was incorrect, please try again.",
                                    preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      present(alert, animated: true, completion: nil)
    }
  }

  func setupPasswordField() {
    passwordField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
    passwordField.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
  }
}
