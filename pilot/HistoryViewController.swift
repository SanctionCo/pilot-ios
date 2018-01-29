//
//  HistoryViewController.swift
//  pilot
//
//  Created by Nick Eckert on 11/19/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import CoreData
import UIKit

class HistoryViewController: UIViewController {

  var history: [Post] = [Post]()

  var containerView: UIView = {
    let container = UIView()
    container.translatesAutoresizingMaskIntoConstraints = false
    container.backgroundColor = UIColor.white
    return container
  }()

  var historyTableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()

  var historyEmptyView: UIView = {
    let emptyView = UIView()
    emptyView.translatesAutoresizingMaskIntoConstraints = false
    return emptyView
  }()

  var historyEmptyImage: UIImageView = {
    let imageView = UIImageView(image: #imageLiteral(resourceName: "bulb"))
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  var historyEmptyMessage: UITextView = {
    let textView = UITextView()
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.text = "There is no history to show..."
    return textView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    // Set the right bar button item to a plus image
    let composeButton = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .plain, target: self, action: #selector(self.compose))
    self.navigationItem.rightBarButtonItem = composeButton

    self.navigationController?.navigationBar.isTranslucent = false
    self.navigationController?.navigationBar.shadowImage = UIImage()

    self.navigationController?.navigationBar.topItem?.title = "History"
    self.navigationController?.navigationBar.prefersLargeTitles = true
    self.navigationController?.navigationItem.largeTitleDisplayMode = .never

    self.historyTableView.delegate = self
    self.historyTableView.dataSource = self

    self.historyTableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: "HistoryTableViewCell")

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

//    self.containerView.addSubview(historyTableView)
//    self.containerView.addSubview(historyEmptyView)
//    self.containerView.sendSubview(toBack: historyEmptyView)
//
//    setupHistoryTableView()
//    setupHistoryEmptyView()
  }

  func setupHistoryTableView() {
    historyTableView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
    historyTableView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
    historyTableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
    historyTableView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
  }

  func setupHistoryEmptyView() {

    // Constrain the historyEmptyView to the center of historyTableView
    historyEmptyView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
    historyEmptyView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
    historyEmptyView.widthAnchor.constraint(equalToConstant: 50).isActive = true
    historyEmptyView.heightAnchor.constraint(equalToConstant: 30).isActive = true

    historyEmptyView.addSubview(historyEmptyImage)
    historyEmptyView.addSubview(historyEmptyMessage)

    // Position the history empty image
    historyEmptyImage.topAnchor.constraint(equalTo: historyEmptyView.topAnchor).isActive = true
    historyEmptyImage.leftAnchor.constraint(equalTo: historyEmptyView.leftAnchor).isActive = true
    historyEmptyImage.heightAnchor.constraint(equalToConstant: 20).isActive = true

    // Position the history empty message
    historyEmptyMessage.topAnchor.constraint(equalTo: historyEmptyImage.bottomAnchor).isActive = true
    historyEmptyMessage.leftAnchor.constraint(equalTo: historyEmptyView.leftAnchor).isActive = true
    historyEmptyMessage.heightAnchor.constraint(equalToConstant: 10)
    historyEmptyMessage.widthAnchor.constraint(equalTo: historyEmptyView.widthAnchor).isActive = true
  }
}

extension HistoryViewController: UITableViewDataSource, UITableViewDelegate {

  // MARK: HistoryTableViewDataSource

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return history.count
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    if history.count == 0 {
      // Hide the tableView to reveal the empty talbeView custom view
      tableView.isHidden = true

      return 0
    }

    // Display the tableView to show it's cells and hide the empty tableView custom view
    tableView.isHidden = false
    return 1
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell") as? HistoryTableViewCell else {
      fatalError("Wrong cell type dequed!")
    }

    return cell
  }
}
