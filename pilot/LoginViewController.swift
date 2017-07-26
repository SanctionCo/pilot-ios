//
//  LoginViewController.swift
//  pilot
//
//  Created by Nick Eckert on 7/24/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, LoginViewDelegate {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var errorField: UILabel!
    
    var loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginViewModel.delegate = self
        
        emailField.becomeFirstResponder()
    }
    
    @IBAction func login(_ sender: UIButton) {
        loginViewModel.login(email: emailField.text, password: passwordField.text)
    }
    
    func loginCallComplete(success: Bool, errorMessage: String) {
        if success {
            performSegue(withIdentifier: "LoginSegue", sender: self)
        } else {
            errorField.text = errorMessage
        }
    }

    
     // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
}
