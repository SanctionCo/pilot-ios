//
//  LoginViewController.swift
//  pilot
//
//  Created by Nick Eckert on 7/24/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, LoginViewModelDelegate {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var errorField: UILabel!
    
    var loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginViewModel.delegate = self
        
        emailField.becomeFirstResponder()
        
        loginViewModel.login(email: "Testy@gmail.com", password: "password")
    }
    
    @IBAction func login(_ sender: UIButton) {
        loginViewModel.login(email: emailField.text, password: passwordField.text)
    }
    
    func loginCallComplete(pilotUser: PilotUser) {
        // Segue to a navigation controller with composeViewController as its root viewController!
        
        let composeViewStoryBoard = UIStoryboard(name: "ComposeView", bundle: nil)
//        guard let composeViewController = composeViewStoryBoard.instantiateViewController(withIdentifier: "ComposeViewController") as? ComposeViewController else {
//            return
//        }
        
        guard let destinationNavigationController = composeViewStoryBoard.instantiateViewController(withIdentifier: "ComposeNavigationController") as? UINavigationController else {
            return
        }
        
        let composeViewController = destinationNavigationController.topViewController as! ComposeViewController
        composeViewController.composeViewModel = ComposeViewModel(pilotUser: pilotUser)
        
        present(destinationNavigationController, animated: true, completion: nil)
    }
    
    func error(message: String) {
        errorField.text = message
    }
    
}
