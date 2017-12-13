//
//  LoginViewController.swift
//  pilot
//
//  Created by Nick Eckert on 7/24/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Alamofire
import HTTPStatusCodes
import SwiftHash
import UIKit

class LoginViewController: UIViewController {

  let profileImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "ProfileImage")
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  let loginRegisterSegmentedControl: UISegmentedControl = {
    let segmentedControl = UISegmentedControl(items: ["Login", "Register"])
    segmentedControl.translatesAutoresizingMaskIntoConstraints = false
    segmentedControl.tintColor = UIColor.white
    segmentedControl.selectedSegmentIndex = 0

    segmentedControl.addTarget(self, action: #selector(updateLoginRegisterView), for: .valueChanged)
    return segmentedControl
  }()

  let inputsContainerView: UIView = {
    let inputsView = UIView()
    inputsView.backgroundColor = UIColor.white
    inputsView.translatesAutoresizingMaskIntoConstraints = false
    inputsView.layer.cornerRadius = 5
    inputsView.layer.masksToBounds = true
    return inputsView
  }()

  let emailTextField: UITextField = {
    let textField = UITextField()
    textField.placeholder = "Email"
    textField.translatesAutoresizingMaskIntoConstraints = false
    return textField
  }()

  let passwordTextField: UITextField = {
    let textField = UITextField()
    textField.placeholder = "Password"
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.isSecureTextEntry = true
    return textField
  }()

  let confirmPasswordTextField: UITextField = {
    let textField = UITextField()
    textField.placeholder = "Re-type Password"
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.isSecureTextEntry = true
    return textField
  }()

  let emailSeparatorView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.LayoutLightGray
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  let passwordSeparatorView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.LayoutLightGray
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  let loginRegisterButton: UIButton = {
    let button = UIButton(type: .system)
    button.backgroundColor = UIColor.PilotDarkBlue
    button.setTitle("Login", for: .normal)
    button.setTitleColor(UIColor.TextWhite, for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.layer.cornerRadius = 5
    button.layer.masksToBounds = true

    button.addTarget(self, action: #selector(handleButtonAction), for: .touchUpInside)
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    navigationController?.navigationBar.isHidden = true

    view.backgroundColor = UIColor.PilotLightBlue
    view.addSubview(profileImageView)
    view.addSubview(loginRegisterSegmentedControl)
    view.addSubview(inputsContainerView)
    view.addSubview(loginRegisterButton)

    setupProfileImageView()
    setupLoginRegisterSegmentedControl()
    setupInputsContainerView()
    setupLoginRegisterButton()

    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: Notification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: Notification.Name.UIKeyboardWillHide, object: nil)
  }

  deinit {
    NotificationCenter.default.removeObserver(self)
  }

  @objc private func handleButtonAction() {
    if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {

    } else {
      // Register state
    }
  }

  var activeKeyboardHeight: CGFloat = 180.0

  @objc private func keyboardWillShow(_ notification: NSNotification) {
//    if let newKeyboardHeight = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
//
//      // Ensure the login button is always the keyboard height + 10px up from the top of the keyboard
//
//
//      // Use the active keyboard height and the new keyboard height to calculate offsets in case new keyboard accessory
//      // view come in to place.
//
//      var difference: CGFloat = 0.0
//      if newKeyboardHeight > activeKeyboardHeight {
//        difference = -(newKeyboardHeight - activeKeyboardHeight)
//      } else {
//        difference = activeKeyboardHeight - newKeyboardHeight
//      }
//
//      activeKeyboardHeight -= difference
//
//      UIView.beginAnimations("Move", context: nil)
//      UIView.setAnimationBeginsFromCurrentState(true)
//      UIView.setAnimationDuration(0.3)
//      self.view.frame = self.view.frame.offsetBy(dx: 0, dy: difference)
//      UIView.commitAnimations()
//    }
  }

  @objc private func keyboardWillHide(_ notification: NSNotification) {
//    if let keyboardHeight = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
//
//      // Move the inputsView back to it's origional position
//      UIView.beginAnimations("MoveOrigional", context: nil)
//      UIView.setAnimationBeginsFromCurrentState(true)
//      UIView.setAnimationDuration(0.3)
//
//      // Calculate the displacement needed to move the view back to the origional origin (x: 0, y: 0)
//      var verticalDisplacement: CGFloat = self.view.frame.height * -1
//
//      // Move the view back to the default 0 origin
//      self.view.frame = self.view.frame.offsetBy(dx: 0, dy: verticalDisplacement)
//      UIView.commitAnimations()
//
//      // Set the active height back to 0.0 incase it shows again later
//      activeKeyboardHeight = 0.0
//    }
  }

  @objc private func updateLoginRegisterView() {

    // Change height of inputsContainerView
    inputsContainerViewHeight?.constant = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 80 : 120

    // Change the height of the passwordSeperatorView
    passwordSeperatorViewHeight?.isActive = false
    passwordSeperatorViewHeight = passwordSeparatorView.heightAnchor
      .constraint(equalToConstant: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 0 : 1)
    passwordSeperatorViewHeight?.isActive = true

    // Change height of the confirmPasswordTextField
    confirmPasswordTextFieldHeight?.isActive = false
    confirmPasswordTextFieldHeight = confirmPasswordTextField.heightAnchor
      .constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 0 : 1/3)
    confirmPasswordTextFieldHeight?.isActive = true

    // Change the height of the emailTextField
    emailTextFieldHeight?.isActive = false
    emailTextFieldHeight = emailTextField.heightAnchor
      .constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
    emailTextFieldHeight?.isActive = true

    // Change the height of the passwordTextField
    passwordTextFieldHeight?.isActive = false
    passwordTextFieldHeight = passwordTextField.heightAnchor
      .constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
    passwordTextFieldHeight?.isActive = true

    // Rename button to "Register"
    loginRegisterButton.setTitle(loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? "Login": "Register", for: .normal)

    view.layoutIfNeeded()
  }

  private func setupProfileImageView() {
    profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    profileImageView.bottomAnchor.constraint(equalTo: loginRegisterSegmentedControl.topAnchor, constant: -50).isActive = true
    profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
    profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor, multiplier: 21/50).isActive = true
  }

  private func setupLoginRegisterSegmentedControl() {
    loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    loginRegisterSegmentedControl.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -12).isActive = true
    loginRegisterSegmentedControl.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
    loginRegisterSegmentedControl.heightAnchor.constraint(equalToConstant: 36).isActive = true
  }

  var inputsContainerViewHeight: NSLayoutConstraint?
  var emailTextFieldHeight: NSLayoutConstraint?
  var passwordTextFieldHeight: NSLayoutConstraint?
  var passwordSeperatorViewHeight: NSLayoutConstraint?
  var confirmPasswordTextFieldHeight: NSLayoutConstraint?

  private func setupInputsContainerView() {

    // Add the subviews to the inputsContainerView
    inputsContainerView.addSubview(emailTextField)
    inputsContainerView.addSubview(passwordTextField)
    inputsContainerView.addSubview(confirmPasswordTextField)
    inputsContainerView.addSubview(passwordSeparatorView)
    inputsContainerView.addSubview(emailSeparatorView)

    // Add constraints to the inputsContainerView
    inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -25).isActive = true
    inputsContainerViewHeight = inputsContainerView.heightAnchor.constraint(equalToConstant: 80)
    inputsContainerViewHeight?.isActive = true

    // Add constraints to the emailTextField
    emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
    emailTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
    emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
    emailTextFieldHeight = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/2)
    emailTextFieldHeight?.isActive = true

    // Add constraints to the emailSeperatorView
    emailSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
    emailSeparatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
    emailSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
    emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true

    // Add constraints to the passwordTextField
    passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
    passwordTextField.topAnchor.constraint(equalTo: emailSeparatorView.bottomAnchor).isActive = true
    passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
    passwordTextFieldHeight = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/2)
    passwordTextFieldHeight?.isActive = true

    // Add constraints to passwordSeperatorView
    passwordSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
    passwordSeparatorView.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor).isActive = true
    passwordSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
    passwordSeperatorViewHeight = passwordSeparatorView.heightAnchor.constraint(equalToConstant: 0)
    passwordSeperatorViewHeight?.isActive = true

    // Add constraints to confirmPasswordTextField
    confirmPasswordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
    confirmPasswordTextField.topAnchor.constraint(equalTo: passwordSeparatorView.bottomAnchor).isActive = true
    confirmPasswordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
    confirmPasswordTextFieldHeight = confirmPasswordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 0)
    confirmPasswordTextFieldHeight?.isActive = true
  }

  private func setupLoginRegisterButton() {
    loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    loginRegisterButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
    loginRegisterButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
    loginRegisterButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
  }
}
