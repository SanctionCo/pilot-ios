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

  private var postState = Post() // Post object to publish

  private var selectedPlatforms = [Platform]()
  private var selectedImages = [UIImage]() {
    didSet {
      self.imageView.image = selectedImages[0]
    }
  }

  private let gallery = GalleryController()

  var scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.keyboardDismissMode = .interactive
    scrollView.backgroundColor = UIColor.white
    return scrollView
  }()

  var textView: UITextView = {
    let view = UITextView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.text = "Write your post here!"
    view.textColor = UIColor.TextGray
    return view
  }()

  var imageView: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = UIViewContentMode.center
    return view
  }()

  lazy var cancelBarButton: UIBarButtonItem = {
    return UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancel))
  }()

  lazy var postBarButton: UIBarButtonItem = {
    return UIBarButtonItem(title: "Post", style: .plain, target: self, action: #selector(self.post))
  }()

  lazy var composeToolBar: UIToolbar = {
    let toolbar = UIToolbar()
    toolbar.translatesAutoresizingMaskIntoConstraints = false

    let cameraButton = UIBarButtonItem(image: #imageLiteral(resourceName: "camera"), style: .plain, target: self, action: #selector(photoPicker))
    toolbar.items = [cameraButton]

    return toolbar
  }()

  override var inputAccessoryView: UIView? { return self.composeToolBar }
  override var canBecomeFirstResponder: Bool { return true }

  override func viewDidLoad() {
    super.viewDidLoad()

    scrollView.frame = self.view.bounds

    // Delegates
    gallery.delegate = self
    textView.delegate = self
    postState.delegate = self

    navigationItem.leftBarButtonItem = cancelBarButton
    navigationItem.rightBarButtonItem = postBarButton

    postBarButton.isEnabled = false

    self.view.addSubview(scrollView)

    setupScrollView()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    self.becomeFirstResponder()
  }

  @objc func photoPicker(_ sender: UIBarButtonItem) {
    self.present(gallery, animated: true, completion: nil)
  }

  @objc func cancel(_ sender: UIBarButtonItem) {
    self.textView.resignFirstResponder()
    self.resignFirstResponder()
    self.dismiss(animated: true, completion: nil)
  }

  @objc func post(_ sender: UIBarButtonItem) {
    // Send the post to Lightning
  }

  func postChanged() {
    if self.textView.text != "" || self.selectedImages.count != 0 {
      self.postBarButton.isEnabled = true
    } else {
      self.postBarButton.isEnabled = false
    }
  }

  func setupScrollView() {
    scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

    scrollView.addSubview(textView)
    scrollView.addSubview(imageView)

    setupTextView()
    setupImageView()
  }

  func setupTextView() {
    textView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20).isActive = true
    textView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
    textView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: 30).isActive = true
    textView.heightAnchor.constraint(equalToConstant: 60).isActive = true
  }

  func setupImageView() {
    imageView.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 20).isActive = true
    imageView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20).isActive = true
    imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
    imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
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
    self.postState.text = self.textView.text
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

      self?.postState.type = PostType.photo
    })
  }

  func galleryController(_ controller: GalleryController, didSelectVideo video: Video) {
    controller.dismiss(animated: true, completion: {
      let editor = VideoEditor()
      editor.edit(video: video) { (_, tempPath: URL?) in
        DispatchQueue.main.async { [weak self] in
          if let tempPath = tempPath {
            self?.postState.video = tempPath
            self?.postState.type = PostType.video
          }
        }
      }

      video.fetchThumbnail(completion: { [weak self] image in
        DispatchQueue.main.async {
          self?.postState.image = image
        }
      })

    })
  }

  func galleryController(_ controller: GalleryController, requestLightbox images: [Image]) { }

  func galleryControllerDidCancel(_ controller: GalleryController) {
    controller.dismiss(animated: true, completion: nil)
  }
}
