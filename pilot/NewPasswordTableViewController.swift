//
//  NewPasswordTableViewController.swift
//  pilot
//
//  Created by Nick Eckert on 10/8/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import SwiftHash
import UIKit

class NewPasswordTableViewController: UITableViewController {

  var newPasswordField: UITextField = {
    let field = UITextField()
    field.translatesAutoresizingMaskIntoConstraints = false
    return field
  }()

  var verifyPasswordField: UITextField = {
    let field = UITextField()
    field.translatesAutoresizingMaskIntoConstraints = false
    return field
  }()

  override func viewDidLoad() {
      super.viewDidLoad()
  }

  func cancel(_ sender: UIBarButtonItem) {
    self.dismiss(animated: true, completion: nil)
  }

  func change(_ sender: UIBarButtonItem) {
//    guard let newPasswordText = newPassword.text, let verifyPasswordText = verifyPassword.text else {
//      return
//    }
//
//    if newPasswordText != verifyPasswordText {
//      let alert = UIAlertController(title: "Passwors do not match", message: nil, preferredStyle: .alert)
//      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//
//      present(alert, animated: true, completion: nil)
//
//      return
//    }
//
//    // Update the password on thunder and navigate back to ProfileViewController
//    let hashedPassword = MD5(newPasswordText).lowercased()
//
//    UserManager.sharedInstance?.setPassword(newPassword: hashedPassword)
//    UserManager.sharedInstance?.updateUser(onSuccess: { [weak self] _ in
//      let alert = UIAlertController(title: "Password update successful!", message: nil, preferredStyle: .alert)
//      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
//        self?.dismiss(animated: true, completion: nil)
//      }))
//      self?.present(alert, animated: true, completion: nil)
//    }, onError: { error in
//      debugPrint(error)
//    })
  }

}
