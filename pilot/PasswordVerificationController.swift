//
//  PasswordVerificationTableViewController.swift
//  pilot
//
//  Created by Nick Eckert on 10/8/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import SwiftHash
import UIKit

class PasswordVerificationController: UIViewController {

  var containerView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = UIColor.white
    return view
  }()

  var passwordField: UITextField = {
    let field = UITextField()
    field.translatesAutoresizingMaskIntoConstraints = false
    field.placeholder = "Enter password"
    field.isSecureTextEntry = true
    field.font = UIFont(name: (field.font?.fontName)!, size: 18)
    return field
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelAction))
    let nextButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(self.nextAction))

    self.navigationItem.rightBarButtonItem = nextButton
    self.navigationItem.leftBarButtonItem = cancelButton

    self.navigationItem.title = "Change Password"

    self.view.addSubview(containerView)

    setupContainerView()
  }

  @objc func cancelAction(_ sender: UIBarButtonItem) {
    self.dismiss(animated: true, completion: nil)
  }

  @objc func nextAction(_ sender: UIBarButtonItem) {
    guard let passwordFieldText = passwordField.text else {
      return
    }

    let hashedPassword = MD5(passwordFieldText).lowercased()
    if hashedPassword == UserManager.sharedInstance?.getPassword() {
      passwordField.text = ""
      let newPasswordController = NewPasswordController()

      self.navigationController?.pushViewController(newPasswordController, animated: true)
    } else {
      let alert = UIAlertController(title: "Incorrect password",
                                    message: "The password you entered was incorrect, please try again.",
                                    preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

      present(alert, animated: true, completion: nil)
    }
  }

  func setupContainerView() {
    containerView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
    containerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    containerView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
    containerView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true

    containerView.addSubview(passwordField)

    setupPasswordField()
  }

  func setupPasswordField() {
    passwordField.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 150).isActive = true
    passwordField.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor).isActive = true
  }
}
