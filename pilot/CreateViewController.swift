//
//  CreateViewController.swift
//  pilot
//
//  Created by Nick Eckert on 8/30/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import UIKit
import SwiftHash

class CreateViewController: UIViewController {
  
  @IBOutlet weak var email: UITextField!
  @IBOutlet weak var password: UITextField!
  @IBOutlet weak var confirmPassword: UITextField!
  @IBOutlet weak var signUpButton: UIButton!
  @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    styleUI()
  }
  
  func styleUI() {
    
    // Button Style Properties
    signUpButton.layer.cornerRadius = 4
    signUpButton.layer.backgroundColor = UIColor.ButtonBlue.cgColor
    
  }
  
  @IBAction func signUp(_ sender: UIButton) {
    signUp(email: email.text, password: password.text, confirmPassword: confirmPassword.text)
  }
  
  fileprivate func signUp(email: String?, password: String?, confirmPassword: String?) {
    
    guard let email = email, let password = password, let confirmPassword = confirmPassword else {
      return
    }
    
    if validate(email: email, password: password, confirmPassword: confirmPassword) {
      let hashedPassword = MD5(password).lowercased()
      let pilotUser = PilotUser(email: email, password: hashedPassword)
      
      activitySpinner.startAnimating()
      signUpButton.isEnabled = false
      
      PilotUser.upload(with: ThunderRouter.createPilotUser(pilotUser), onSuccess: { _ in
        
        DispatchQueue.main.async { [weak self] in
          self?.activitySpinner.stopAnimating()
          self?.signUpButton.isEnabled = true
          self?.navigationController?.popViewController(animated: true)
        }
        
      }, onError: { error in
        
        DispatchQueue.main.async { [weak self] in
          self?.activitySpinner.stopAnimating()
          self?.signUpButton.isEnabled = true
        }
        
      })
    }
    
  }
  
  fileprivate func validate(email: String, password: String, confirmPassword: String) -> Bool {
    
    if email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
      alert(message: "Cannot have empty fields", title: "Invalid Input")
      return false
    }
    
    if password != confirmPassword {
      alert(message: "Password fields do not match", title: "Invalid Input")
      return false
    }
    
    return true
  }
  
}
