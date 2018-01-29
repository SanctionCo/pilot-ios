//
//  SelectionViewController.swift
//  pilot
//
//  Created by Nick Eckert on 1/26/18.
//  Copyright © 2018 sanction. All rights reserved.
//

import UIKit

class SelectionViewController: UIViewController {

  var post: Post?
  var potentialPlatforms = UserManager.sharedInstance.getAvailablePlatforms() { didSet { postBarButton.isEnabled = selectedCount > 0 ? true : false }}
  var selectedCount: Int { return potentialPlatforms.filter{ $0.isSelected }.count }

  lazy var cancelBarButton: UIBarButtonItem = {
    return UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelAction))
  }()

  lazy var postBarButton: UIBarButtonItem = {
    return UIBarButtonItem(title: "Post", style: .plain, target: self, action: #selector(self.postAction))
  }()

  var selectionTableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.allowsMultipleSelection = true
    return tableView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    navigationItem.leftBarButtonItem = cancelBarButton
    navigationItem.rightBarButtonItem = postBarButton

    selectionTableView.delegate = self
    selectionTableView.dataSource = self

    selectionTableView.register(SelectionCell.self, forCellReuseIdentifier: "SelectionCell")

    postBarButton.isEnabled = false // false until validation

    self.view.addSubview(selectionTableView)

    self.setupSelectionTableView()
  }

  @objc private func cancelAction() {
    self.dismiss(animated: true, completion: nil)
  }

  @objc private func postAction() {
    guard let post = post else {
      fatalError("Failed to read post")
    }

    // Post to each selected platform
    for platform in potentialPlatforms where platform.isSelected {

      // Message and type for upload router
      var params = ["type": post.type.rawValue]
      if let message = post.text {
        params["message"] = message
      }

      // Upload the post to the platform
      Post.publish(post: post, with: LightningRouter.publish(platform.type, params), onProgress: { _ in
        // Display progress to the UI
      }, onSuccess: {
        let alert = UIAlertController(title: "Success!",
                                      message: "Post was successfully published!",
                                      preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))

        self.present(alert, animated: true, completion: nil)
      }, onError: { error in
        debugPrint(error)
      })
    }
  }

  private func setupSelectionTableView() {
    selectionTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
    selectionTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    selectionTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
    selectionTableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
  }
}

extension SelectionViewController: UITableViewDelegate, UITableViewDataSource {

  // MARK: UITableViewDelegate

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return potentialPlatforms.count
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let cell = tableView.cellForRow(at: indexPath) as? SelectionCell else {
      fatalError("Failed to fetch cell from SelectionTableView")
    }

    // Mark the platform as selected
    potentialPlatforms[indexPath.row].isSelected = true

    // Update the cell state to show as selected
    cell.isSelected = true
  }

  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    guard let cell = tableView.cellForRow(at: indexPath) as? SelectionCell else {
      fatalError("Failed to fetch cell from SelectionTableView")
    }

    // Mark the platform as deselected
    potentialPlatforms[indexPath.row].isSelected = false

    // Update the cell state to show as deselected
    cell.isSelected = false
  }

  // MARK: UITableViewDataSource

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = selectionTableView.dequeueReusableCell(withIdentifier: "SelectionCell") as? SelectionCell else {
      fatalError("Failed to dequeue a reusable cell for SelectionTableView")
    }

    let cellModel = potentialPlatforms[indexPath.row]
    cell.title = cellModel.type.rawValue

    return cell
  }
}
