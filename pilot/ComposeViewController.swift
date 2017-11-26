//
//  ComposeViewController.swift
//  pilot
//
//  Created by Nick Eckert on 11/19/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Gallery
import UIKit

class ComposeViewController: UIViewController {

  @IBOutlet weak var textView: UITextView!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var postButton: UIBarButtonItem!

  internal var post = Post() // Post object to publish

  // Post attributes
  private var selectedPlatforms = [Platform]()
  private var selectedImages = [UIImage]() {
    didSet {
      self.imageView.image = selectedImages[0]
    }
  }
  private let gallery = GalleryController()

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
    gallery.delegate = self
    textView.delegate = self
    post.delegate = self

    // Post button is disabled until minimum requirnments are met (PostChanged)
    postButton.isEnabled = false

    // Set up the placeholder text for the textView
    textView.text = "Write your post here!"
    textView.textColor = UIColor.TextGray
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    self.becomeFirstResponder()
  }

  @IBAction func photoPicker(_ sender: UIBarButtonItem) {
    self.present(gallery, animated: true, completion: nil)
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

extension ComposeViewController: ComposeViewControllerDelegate {
  func didUpdateText(text: String) { }

  func didUpdateImage(image: UIImage) {
    self.imageView.image = image
  }

  func didUpdateVideo(video: URL) { }
  func didUpdateType(type: PostType) { }
}

extension ComposeViewController: UIToolbarDelegate { }

extension ComposeViewController: UITextViewDelegate {
  func textViewDidChange(_ textView: UITextView) {
    self.postChanged()
    self.post.text = self.textView.text
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

extension ComposeViewController: GalleryControllerDelegate {
  func galleryController(_ controller: GalleryController, didSelectImages images: [Image]) {
    controller.dismiss(animated: true, completion: { [weak self] in
      if let image = images[0].uiImage(ofSize: (self?.imageView.intrinsicContentSize)!) {
        self?.imageView.image = image
      }
      self?.post.type = PostType.photo
    })
  }

  func galleryController(_ controller: GalleryController, didSelectVideo video: Video) {
    controller.dismiss(animated: true, completion: {
      let editor = VideoEditor()
      editor.edit(video: video) { (_, tempPath: URL?) in
        DispatchQueue.main.async { [weak self] in
          if let tempPath = tempPath {
            self?.post.video = tempPath
            self?.post.type = PostType.video
          }
        }
      }

      video.fetchThumbnail(completion: { [weak self] image in
        DispatchQueue.main.async {
          self?.post.image = image
        }
      })

    })
  }

  func galleryController(_ controller: GalleryController, requestLightbox images: [Image]) { }

  func galleryControllerDidCancel(_ controller: GalleryController) {
    controller.dismiss(animated: true, completion: nil)
  }
}
