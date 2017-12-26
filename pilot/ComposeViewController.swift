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

  internal var post = Post() // Post object to publish

  var contentView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  var textView: UITextView = {
    let view = UITextView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  var imageView: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  var postButton: UIBarButtonItem = {
    let barButton = UIBarButtonItem()

    return barButton
  }()

  var scrollView: UIScrollView = {
    let view = UIScrollView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

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

    scrollView.keyboardDismissMode = .interactive

    imageView.contentMode = UIViewContentMode.center
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    self.becomeFirstResponder()
  }

  func photoPicker(_ sender: UIBarButtonItem) {
    self.present(gallery, animated: true, completion: nil)
  }

  func post(_ sender: UIBarButtonItem) {

  }

  func cancel(_ sender: UIBarButtonItem) {
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

// -- COMPOSE VIEW CONTROLLER DELEGATE --
extension ComposeViewController: ComposeViewControllerDelegate {
  func didUpdateText(text: String) { }

  func didUpdateImage(image: UIImage) {
    self.imageView.image = image
  }

  func didUpdateVideo(video: URL) { }
  func didUpdateType(type: PostType) { }
}

// -- TOOLBAR DELEGATE --
extension ComposeViewController: UIToolbarDelegate { }

// -- TEXT VIEW DELEGATE --
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

// -- GALLERY CONTROLLER DELEGATE --
extension ComposeViewController: GalleryControllerDelegate {
  func galleryController(_ controller: GalleryController, didSelectImages images: [Image]) {
    controller.dismiss(animated: true, completion: { [weak self] in
      let imageContainerSize = self?.imageView.bounds.size
      if let image = images[0].uiImage(ofSize: imageContainerSize!) {

        // Resize the image to the imageView width
        let newImage = UIImage.resizeImageWithWidth(image: image, width: (self?.imageView.bounds.width)!)

        // Resize the imageView height contraint to match that of the resized image
        //self?.imageViewHeight.constant = newImage.size.height
        self?.imageView.layoutIfNeeded()
        self?.imageView.image = newImage
      }

      self?.post.type = PostType.photo
    })
  }

  func galleryController(_ controller: GalleryController, didSelectVideo video: Video) {
//    controller.dismiss(animated: true, completion: {
//      let editor = VideoEditor()
//      editor.edit(video: video) { (_, tempPath: URL?) in
//        DispatchQueue.main.async { [weak self] in
//          if let tempPath = tempPath {
//            self?.post.video = tempPath
//            self?.post.type = PostType.video
//          }
//        }
//      }
//
//      video.fetchThumbnail(completion: { [weak self] image in
//        DispatchQueue.main.async {
//          self?.post.image = image
//        }
//      })
//
//    })
  }

  func galleryController(_ controller: GalleryController, requestLightbox images: [Image]) { }

  func galleryControllerDidCancel(_ controller: GalleryController) {
    controller.dismiss(animated: true, completion: nil)
  }
}
