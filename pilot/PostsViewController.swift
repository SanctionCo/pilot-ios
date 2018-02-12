//
//  HistoryViewController.swift
//  pilot
//
//  Created by Nick Eckert on 11/19/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import CoreData
import UIKit

class PostsViewController: UIViewController {

  var posts: [Post] = [Post]()

  var containerView: UIView = {
    let container = UIView()
    container.translatesAutoresizingMaskIntoConstraints = false
    container.backgroundColor = UIColor.white
    return container
  }()

  var postsTableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()

  var postsEmptyView: UIView = {
    let emptyView = UIView()
    emptyView.translatesAutoresizingMaskIntoConstraints = false
    return emptyView
  }()

  var postsEmptyImage: UIImageView = {
    let imageView = UIImageView(image: #imageLiteral(resourceName: "bulb"))
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = imageView.image!.withRenderingMode(.alwaysTemplate)
    imageView.tintColor = UIColor.TextGray
    return imageView
  }()

  var postsEmptyMessage: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "There are no posts to show..."
    label.textColor = UIColor.TextGray
    label.font = label.font?.withSize(15)
    label.textAlignment = .center
    label.sizeToFit()
    return label
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    // Set the right bar button item to a plus image
    let composeButton = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .plain, target: self, action: #selector(self.compose))
    self.navigationItem.rightBarButtonItem = composeButton

    self.navigationController?.navigationBar.isTranslucent = false
    self.navigationController?.navigationBar.shadowImage = UIImage()

    self.navigationController?.navigationBar.topItem?.title = "Posts"
    self.navigationController?.navigationBar.prefersLargeTitles = true
    self.navigationController?.navigationItem.largeTitleDisplayMode = .never

    self.postsTableView.delegate = self
    self.postsTableView.dataSource = self

    self.postsTableView.rowHeight = 50
    self.postsTableView.separatorStyle = .none

    self.postsTableView.register(PostsTableViewCell.self, forCellReuseIdentifier: "PostsTableViewCell")

    self.view.addSubview(containerView)

    setupContainerView()
  }

  @objc func compose(_ sender: UIBarButtonItem) {
    let composeViewController = ComposeViewController()
    let composeNavigationController = UINavigationController(rootViewController: composeViewController)
    self.present(composeNavigationController, animated: true, completion: nil)
  }

  func setupContainerView() {
    self.containerView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
    self.containerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    self.containerView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
    self.containerView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true

    self.containerView.addSubview(postsTableView)
    self.containerView.addSubview(postsEmptyView)
    self.containerView.sendSubview(toBack: postsEmptyView)

    setupPostsEmptyView()
    setupPostsTableView()
  }

  func setupPostsTableView() {
    postsTableView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
    postsTableView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
    postsTableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
    postsTableView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
  }

  func setupPostsEmptyView() {

    // Setup the postEmptyView
    postsEmptyView.widthAnchor.constraint(equalToConstant: 300).isActive = true
    postsEmptyView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    postsEmptyView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
    postsEmptyView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true

    postsEmptyView.addSubview(postsEmptyImage)
    postsEmptyView.addSubview(postsEmptyMessage)

    // Position the history empty image
    postsEmptyImage.topAnchor.constraint(equalTo: postsEmptyView.topAnchor).isActive = true
    postsEmptyImage.centerXAnchor.constraint(equalTo: postsEmptyView.centerXAnchor).isActive = true
    postsEmptyImage.heightAnchor.constraint(equalToConstant: 75).isActive = true
    postsEmptyImage.widthAnchor.constraint(equalToConstant: 75).isActive = true

    // Position the history empty message
    postsEmptyMessage.topAnchor.constraint(equalTo: postsEmptyImage.bottomAnchor, constant: 15).isActive = true
    postsEmptyMessage.centerXAnchor.constraint(equalTo: postsEmptyView.centerXAnchor).isActive = true
    postsEmptyMessage.widthAnchor.constraint(equalTo: postsEmptyView.widthAnchor).isActive = true
  }
}

extension PostsViewController: UITableViewDataSource, UITableViewDelegate {

  // MARK: HistoryTableViewDataSource

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return posts.count
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    if posts.count == 0 {
      // Hide the tableView to reveal the empty talbeView custom view
      tableView.isHidden = true

      return 0
    }

    // Display the tableView to show it's cells and hide the empty tableView custom view
    tableView.isHidden = false
    return 1
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostsTableViewCell") as? PostsTableViewCell else {
      fatalError("Wrong cell type dequed!")
    }

    // Configure cell here

    return cell
  }
}
