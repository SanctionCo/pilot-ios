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
    
    var imagePicker = UIImagePickerController()
    
    // View Models
    var homeViewModel: HomeViewModel?
    var userPlatforms = [PlatformViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleUI() // Put all styling properties unavailable in interface builder here
        loadUI()  // Request all data needed to immedietly deisplay the UI
        
        homeViewModel?.delegate = self
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
    
    func loadUI() {
//        if let userPlatforms = homeViewModel?.userPlatforms {
//            self.userPlatforms = userPlatforms
//        }
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

// MARK: SettingViewModelDelegate

extension HomeViewController: SettingsViewModelDelegate {}

// MARK: UITableView Methods

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userPlatforms.count
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
        
        cell.platformViewModel = userPlatforms[indexPath.row]
        
        return cell
    }
    
}

// MARK: ComposeViewModelDelegate

extension HomeViewController: HomeViewModelDelegate {
    
    func error(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
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
