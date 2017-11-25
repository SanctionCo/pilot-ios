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
  @IBOutlet weak var postButton: UIBarButtonItem!

  // Post attributes
  private var selectedPlatforms = [Platform]()
  private var selectedImages = [UIImage]()
  private let imagePicker = ImagePickerController()

  override var inputAccessoryView: UIView? { get { return self.composeToolBar }}
  override var canBecomeFirstResponder: Bool { return true }

  // swiftlint:disable force_cast
  lazy var composeToolBar: UIToolbar = {
    return Bundle.main.loadNibNamed("ComposeToolbarView", owner: self, options: nil)?.first as! UIToolbar
  }()
  // swiftlint:enable force_cast

  override func viewDidLoad() {
    super.viewDidLoad()

    // Delegates
    imagePicker.delegate = self
    textView.delegate = self

    // Post button is disabled until minimum requirnments are met (PostChanged)
    postButton.isEnabled = false

    // Set up the placeholder text for the textView
    textView.text = "Write your post here!"
    textView.textColor = UIColor.TextGray

//    textView.becomeFirstResponder()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    self.becomeFirstResponder()
  }

  @IBAction func photoPicker(_ sender: UIBarButtonItem) {
    self.present(imagePicker, animated: true, completion: nil)
  }

  @IBAction func post(_ sender: UIBarButtonItem) {

  }

  @IBAction func cancel(_ sender: UIBarButtonItem) {
    self.textView.resignFirstResponder()
    self.resignFirstResponder()
    self.dismiss(animated: true, completion: nil)
  }

  func postChanged() {
    if self.textView.text != "" || self.selectedImages.count != 0 {
      self.postButton.isEnabled = true
    } else {
      self.postButton.isEnabled = false
    }
  }
}

extension ComposeViewController: UIToolbarDelegate { }

extension ComposeViewController: UITextViewDelegate {
  func textViewDidChange(_ textView: UITextView) {
    self.postChanged()
  }

  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.textColor == UIColor.TextGray {
      textView.text = ""
      textView.textColor = UIColor.TextBlack
    }
  }

  func textViewDidEndEditing(_ textView: UITextView) {
    if textView.text.isEmpty {
      textView.text = "Write your post here!"
      textView.textColor = UIColor.TextGray
    }
  }
}

extension ComposeViewController: ImagePickerDelegate {
  func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) { }

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
