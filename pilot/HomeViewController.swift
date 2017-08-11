//
//  ComposeViewController.swift
//  pilot
//
//  Created by Nick Eckert on 7/26/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var postText: UITextView!
    @IBOutlet weak var chosenImage: UIImageView!
    @IBOutlet weak var publishButton: UIButton!
    
    var imagePicker = UIImagePickerController() // TODO: Injection?
    var availablePlatforms = [Platform]()       // Platforms the user has to choose from
    var selectedPlatforms = [Platform]()        // Platforms the user has selected to upload to
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleUI() // Put all styling properties unavailable in interface builder here
        
        imagePicker.delegate = self
        postText.delegate = self
    }
    
    @IBAction func pickImage(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func takeImage(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func publish(_ sender: UIButton) {
        //publish(postText.text, chosenImage.image)
    }
    
    @IBAction func clear(_ sender: UIBarButtonItem) {
        postText.text = ""
        postText.endEditing(true)
        chosenImage.image = nil
    }
    
    func styleUI() {
        
        // Button Style Properties
        publishButton.layer.cornerRadius = 4
        publishButton.layer.backgroundColor = UIColor.PilotBlue.cgColor
        
        // TextView Style Properties
        postText.text = "Write post here"
        postText.textColor = UIColor.lightGray
        
    }
    
    /// Upload data to provided destination platroms
    ///
    /// - Parameters:
    ///   - text: User text
    ///   - image: User selected image
    ///   - platforms: List of destination platforms
    func publish(text: String, image: UIImage?, platforms: [Platform]) {
        
        // Validate that at least one field is not empty
        if validate() && !platforms.isEmpty {
            
        }
        
    }
    
    
    /// Validates that the user has provided sufficient information to publish
    ///
    /// - Parameters:
    /// - Returns: boolean indicating valid or invalid fields
    fileprivate func validate() -> Bool {
        
        // NOTE: Text is not optional because the field will be empty by default thus always having a value
        
        if postText.text.isEmpty && chosenImage.image == nil {
            // Write error message to view
            
            return false
        }
        
        return true
    }
    
    // MARK: Segue to SettingsViewController or AddPlatformViewController
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Pass information to the settingsViewController here
        //        if let destinationViewController = segue.destination as? AddPlatformViewController {
        //            destinationViewController.platformListViewModel = PlatformListViewModel(platformList: composeViewModel.platformsToChoose())
        //        }
        
        // Pass list of current platforms to AddPlatformViewModel in the AddPlatformViewController
        
    }
    
}

// MARK: UITableView Methods

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availablePlatforms.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.tintColor = UIColor.green
            cell.accessoryType = .checkmark
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComposeTableViewCell") as! ComposeTableViewCell
        cell.platform = availablePlatforms[indexPath.row]
        
        return cell
    }
    
}

// MARK: TextViewDelegate

extension HomeViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Write post here..."
            textView.textColor = UIColor.lightGray
        }
        
    
    }
    
}

// MARK: UIImagePickerControllerDelegate

extension HomeViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            chosenImage.contentMode = .scaleAspectFit
            
            self.chosenImage.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
