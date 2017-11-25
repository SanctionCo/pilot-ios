//
//  ComposeViewController.swift
//  pilot
//
//  Created by Nick Eckert on 11/19/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import ImagePicker
import UIKit

class ComposeViewController: UIViewController {

  @IBOutlet weak var textView: UITextView!
  @IBOutlet var composeToolbar: UIToolbar!
  @IBOutlet weak var postButton: UIBarButtonItem!
  @IBOutlet weak var scrollView: UIScrollView!

  private var selectedPlatforms = [Platform]()
  private var selectedImages = [UIImage]()
  private let imagePicker = ImagePickerController()

  override func viewDidLoad() {
    super.viewDidLoad()

    postButton.isEnabled = false

    imagePicker.delegate = self
    textView.delegate = self

    // Add the compose toolbarView to the keyboard
    if let composeToolbarView =
      Bundle.main.loadNibNamed("ComposeToolbarView", owner: self, options: nil)?.first as? UIToolbar {
      textView.inputAccessoryView = composeToolbarView
    }

    textView.becomeFirstResponder()
  }

  @IBAction func photoPicker(_ sender: UIBarButtonItem) {
    self.present(imagePicker, animated: true, completion: nil)
  }

  @IBAction func post(_ sender: UIBarButtonItem) {

  }

  @IBAction func cancel(_ sender: UIBarButtonItem) {
    self.textView.resignFirstResponder()
    self.dismiss(animated: true, completion: nil)
  }

  func postChanged() {
    print("Post changed called!")
    if self.textView.text != "" || self.selectedImages.count != 0 {
      print("Post was valid")
      self.postButton.isEnabled = true
    } else {
      print("Post was invalid")
      self.postButton.isEnabled = false
    }
    print("End post changed call")
  }
}

extension ComposeViewController: UITextViewDelegate {
  func textViewDidChange(_ textView: UITextView) {
    self.postChanged()
  }
}

extension ComposeViewController: ImagePickerDelegate {
  func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {

  }

  func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
    imagePicker.dismiss(animated: true, completion: nil)
  }

  func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
    imagePicker.dismiss(animated: true, completion: {
      self.selectedImages = images

      self.postChanged()
    })
  }
}

extension ComposeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return selectedImages.count
  }

  // swiftlint:disable force_cast
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView
      .dequeueReusableCell(withReuseIdentifier: "composeCollectionView", for: indexPath) as! ComposeCollectionViewCell

    return cell
  }
  // swiftlint:enable force_cast
}
