//
//  LoginViewController.swift
//  pilot
//
//  Created by Nick Eckert on 7/24/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import UIKit
import SwiftHash
import Alamofire
import HTTPStatusCodes

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var errorField: UILabel!
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.becomeFirstResponder()
        
        styleUI()
        
        // TEMPORARY for faster login
        // self.login(email: "Testy@gmail.com", password: "password")
        self.emailField.text = "Testy@gmail.com"
        self.passwordField.text = "password"
    }
    
    func styleUI() {
        
        // Button Style Properties
        loginButton.layer.cornerRadius = 4
        loginButton.layer.backgroundColor = UIColor.ButtonBlue.cgColor
        
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        
        // Navigate to the signUp view
        let createStoryBoard = UIStoryboard.init(name: "CreateView", bundle: nil)
        let createViewController = createStoryBoard.instantiateViewController(withIdentifier: "CreateViewController")
        
        self.navigationController?.pushViewController(createViewController, animated: true)
    }
    
    @IBAction func login(_ sender: UIButton) {
        login(email: emailField.text, password: passwordField.text)
    }
    
    
    /// Logs a user in using and email and password
    ///
    /// - Parameters:
    ///   - email: email associated with a user account
    ///   - password: password associated with a user account
    func login(email: String?, password: String?) {
        
        guard let email = email, let password = password else { return }

        if validate(email: email, password: password) {
            let hashedPassword = MD5(password).lowercased()
            
            activitySpinner.startAnimating()
            loginButton.isEnabled = false
            
            // Make the request
            PilotUser.fetch(with: ThunderRouter.login(email, hashedPassword), onSuccess: { pilotUser in
                
                // Set a request adapter for future network calls
                let token = AuthToken(email: email, password: hashedPassword)
                NetworkManager.sharedInstance.adapter = AuthAdapter(authToken: token)
                
                let homeStoryBoard = UIStoryboard.init(name: "HomeView", bundle: nil)
                let destinationNavigationController = homeStoryBoard.instantiateViewController(withIdentifier: "HomeNavigationController") as! UINavigationController
                
                let homeViewController = destinationNavigationController.topViewController as! HomeViewController
                print(pilotUser.availablePlatforms)
                homeViewController.availablePlatforms = pilotUser.availablePlatforms
                
                DispatchQueue.main.async { [weak self] in
                    self?.activitySpinner.stopAnimating()
                    self?.loginButton.isEnabled = true
                    self?.present(destinationNavigationController, animated: true, completion: nil)
                }
            }, onError: { error in
                
                DispatchQueue.main.async { [weak self] in
                    self?.activitySpinner.stopAnimating()
                    self?.loginButton.isEnabled = true
                    self?.errorField.text = error.localizedDescription
                }

            })
        
        }
    }
    
    
    /// Validates that required fields are filled
    ///
    /// - Parameters:
    ///   - email: email associated with a user account
    ///   - password: password associated with a user account
    /// - Returns: wether or not the email or password are valid
    fileprivate func validate(email: String, password: String) -> Bool {
        
        if email.isEmpty || password.isEmpty {
            errorField.text = "Cannot have empty email or password fields"
            
            return false
        }
        
        return true
    }
    
}
