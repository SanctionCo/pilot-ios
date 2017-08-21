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
    
    var imagePicker = UIImagePickerController()                   // TODO: Injection?
    var availablePlatforms: [Platform]?                           // Platforms the user has to choose from
    
    var uploadService: UploadService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleUI() // Put all styling properties unavailable in interface builder here
        loadUI()  // Load all data needed immedietly by the view
        
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
        publish(text: postText.text, image: chosenImage.image)
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
        
        // TODO: Make this modular for any keyboard that needs this
        // Set up the keyboard toolbar
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.doneButtonClicked))
        
        let keyboardToolBar = UIToolbar()
        keyboardToolBar.sizeToFit()
        keyboardToolBar.setItems([doneButton], animated: true)
        
        postText.inputAccessoryView = keyboardToolBar
    }
    
    func loadUI() {
        
    }
    
    /// Upload data to provided destination platroms
    ///
    /// - Parameters:
    ///   - text: User text
    ///   - image: User selected image
    func publish(text: String, image: UIImage?) {
        
        // TODO: Disable publish button while network call is active!
        
        // Validate that at least one field is not empty
        guard let uploadService = uploadService, let availablePlatforms = availablePlatforms, validate() else {
            print("VALIDATION FAILED!!!")
            return
        }
        
        // Create the post
        // TODO: Create own object for images and videos that hold a PostType
        let post = Post(text: postText.text, image: chosenImage.image, postType: PostType.photo)
        
        // Upload to the selected platforms
        for platform in availablePlatforms {
            if platform.selected && platform.validate(post: post) {
                platform.delegate?.loading = true
                uploadService.upload(post: post, to: platform.type) {
                    DispatchQueue.main.async {
                        platform.delegate?.loading = false
                    }
                }
            }
        }
        
    }
    
    /// Validates that the user has provided sufficient information to publish
    ///
    /// - Parameters:
    /// - Returns: boolean indicating valid or invalid fields
    fileprivate func validate() -> Bool {
        
        // NOTE: Text is not optional because the field will be empty by default thus always having a value
        
        if postText.text.isEmpty && chosenImage.image == nil {
            // TODO: Write error message to view
            
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
        
    }
    
}

// MARK: UITableView Methods

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: UITableViewDelegate
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availablePlatforms!.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? HomeTableViewCell {
            if cell.loading {
                return
            }
            
            cell.tintColor = UIColor.green
            cell.accessoryType = .checkmark
            
            // Set platform as selected
            let cellIndex = availablePlatforms?.index(of: cell.platform)!
            availablePlatforms?[cellIndex!].selected = true
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? HomeTableViewCell {
            if cell.loading {
                return
            }
            
            cell.accessoryType = .none
            
            // Set platform as unselected
            let cellIndex = availablePlatforms?.index(of: cell.platform)!
            availablePlatforms?[cellIndex!].selected = false
        }
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Cell entered memory
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as! HomeTableViewCell
        cell.platform = availablePlatforms?[indexPath.row]
        cell.platform.delegate = cell
        
        return cell
    }
    
}

// MARK: TextViewDelegate

extension HomeViewController: UITextViewDelegate {
    
    // TODO: The placeholder text is a little buggy, look into this.
    
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
    
    func doneButtonClicked() {
        view.endEditing(true)
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
