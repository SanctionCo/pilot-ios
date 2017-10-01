//
//  ComposeViewController.swift
//  pilot
//
//  Created by Nick Eckert on 7/26/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import UIKit
import AVFoundation

class HomeViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var postText: UITextView!
    @IBOutlet weak var chosenImage: UIImageView!
    @IBOutlet weak var publishButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    var imagePicker = UIImagePickerController()                   // TODO: Injection?
    var availablePlatforms: [Platform]?                           // Platforms the user has to choose from
    var post = Post()                                             // Post object representing current user post state
    
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
        imagePicker.mediaTypes = ["public.image", "public.movie"]
        
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
    
    @IBAction func settings(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard.init(name: "SettingsView", bundle: nil)
        let settingsViewController = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        
        self.navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
    func styleUI() {
        
        // Button Style Properties
        publishButton.layer.cornerRadius = 4
        publishButton.layer.backgroundColor = UIColor.ButtonBlue.cgColor
        
        // TextView Style Properties
        postText.text = "Write post here"
        postText.textColor = UIColor.lightGray
        
        // TODO: Make this modular for any keyboard that needs this
        // Set up the keyboard toolbar
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.doneButtonClicked))
        doneButton.style = UIBarButtonItemStyle.done
        
        
        let keyboardToolBar = UIToolbar()
        keyboardToolBar.sizeToFit()
        keyboardToolBar.setItems([doneButton], animated: true)
        
        postText.inputAccessoryView = keyboardToolBar
        
    }
    
    func loadUI() {
        self.availablePlatforms = PlatformManager.sharedInstance.fetchConnectedPlatforms()
    }
    
    /// Upload data to provided destination platroms
    ///
    /// - Parameters:
    ///   - text: User text
    ///   - image: User selected image
    func publish(text: String, image: UIImage?) {
        
        // TODO: Disable publish button while network call is active!
        
        // Validate that at least one field is not empty
        guard let availablePlatforms = availablePlatforms, validate(post: post) else { return }
        
        // Upload to the selected platforms
        for platform in availablePlatforms {
            if platform.isSelected {
                let parameters = ["type": post.postType.rawValue, "message": post.text]

                // Make the request
                Post.publish(post: post, with: LightningRouter.publish(platform.type, parameters), onProgress: { value in
                    // Output upload status to view
                }, onSuccess: {
                    // Output oossible success to view
                }, onError: { error in
                    // Output/handle error in view
                })

            }
        }
        
    }
    
    /// Validates that the user has provided sufficient information to publish
    ///
    /// - Parameters:
    /// - Returns: boolean indicating valid or invalid fields
    fileprivate func validate(post: Post) -> Bool {
        
        // TODO: Display alter if not platform has been selected!
        
        // The only time a post should fail is if both text and image are empty or if text is only present and it's empty
        if post.text.isEmpty && post.thumbNailImage == nil {
            alert(message: "Cannot have empty text and image", title: "Invalid Input")
            
            return false
        }
        
        return true
    }
    
    func thumbNailDidUpdate(image: UIImage) {
        self.chosenImage.image = image
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

            cell.tintColor = UIColor.ButtonBlue
            cell.accessoryType = .checkmark
            
            // Set platform as selected
            let cellIndex = availablePlatforms?.index(of: cell.platform)!
            availablePlatforms?[cellIndex!].isSelected = true
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? HomeTableViewCell {
            
            cell.accessoryType = .none
            
            // Set platform as unselected
            let cellIndex = availablePlatforms?.index(of: cell.platform)!
            availablePlatforms?[cellIndex!].isSelected = false
        }
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as! HomeTableViewCell
        cell.platform = availablePlatforms?[indexPath.row]
        
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
        
        post.text = textView.text
    }
    
    @objc func doneButtonClicked() {
        view.endEditing(true)
    }
    
}

// MARK: UIImagePickerControllerDelegate

extension HomeViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let mediaType = info[UIImagePickerControllerMediaType] as? String {

            if mediaType == "public.image" {
                // Image selected
                
                if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
                    
                    // Update the model
                    self.post.thumbNailImage = pickedImage
                    self.post.postType = .photo
                }
                
            }
            
            if mediaType == "public.movie" {
                // Video selected
                
                if let pickedVideoURL = info[UIImagePickerControllerMediaURL] as? URL {
                    
                    // TODO: Make this asynchronous and add a loding spinner to the thumbnail spot!
                    let pickedVideoImage = generateThumnail(url: pickedVideoURL, fromTime: 0)
                    
                    // Update the model
                    self.post.thumbNailImage = pickedVideoImage
                    self.post.postType = .video
                    
                    print("Video URL: \(pickedVideoURL.absoluteString)")
                    self.post.fileURL = pickedVideoURL.absoluteURL
                }
            }
            
        }
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            chosenImage.contentMode = .scaleAspectFit
            
            self.chosenImage.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Extracts an image from a video
    func generateThumnail(url : URL, fromTime: Float64) -> UIImage? {
        let asset = AVAsset(url: url)
        let assetGenerator = AVAssetImageGenerator(asset: asset)
        assetGenerator.appliesPreferredTrackTransform = true
        
        let time = CMTime(seconds: 1, preferredTimescale: 60)
        if let image = try? assetGenerator.copyCGImage(at: time, actualTime: nil) {
            return UIImage(cgImage: image)
        }
        
        return nil
    }
    
}

extension UIViewController {
    
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
