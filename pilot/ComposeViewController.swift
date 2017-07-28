//
//  ComposeViewController.swift
//  pilot
//
//  Created by Nick Eckert on 7/26/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, ComposeViewModelDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextViewDelegate {
    
    @IBOutlet weak var postText: UITextView!
    @IBOutlet weak var chosenImage: UIImageView!
    @IBOutlet weak var publishButton: UIButton!
    
    var composeViewModel: ComposeViewModel!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Button Style Properties
        publishButton.layer.cornerRadius = 4
        publishButton.layer.backgroundColor = UIColor.ButtonBlue.cgColor
        
        // TextView Style Properties
        postText.text = "Write post here"
        postText.textColor = UIColor.lightGray
        
        imagePicker.delegate = self
        postText.delegate = self
    }
    
    @IBAction func pickImage(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }

    @IBAction func publish(_ sender: UIButton) {
        // composeViewModel.publish(text: postText.text, image: chosenImage.image, platforms: )
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            chosenImage.contentMode = .scaleAspectFit
            
            composeViewModel?.chosenImage = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func didSetImage(image: UIImage) {
        chosenImage.image = image
    }
    
    func error(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: TextViewDelegate
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Placeholder"
            textView.textColor = UIColor.lightGray
        }
    }
    
    // MARK: Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Pass information to the settingsViewController here
        if let destinationViewController = segue.destination as? AddPlatformViewController {
            destinationViewController.platformListViewModel = PlatformListViewModel(platformList: composeViewModel.platformsToChoose())
        }
        
        // Pass list of current platforms to AddPlatformViewModel in the AddPlatformViewController
        
    }
    
}

// MARK: SettingViewModelDelegate

extension ComposeViewController: SettingsViewModelDelegate {
    
}

// MARK: UITableViewDelegate UITableViewDataSource

extension ComposeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}
