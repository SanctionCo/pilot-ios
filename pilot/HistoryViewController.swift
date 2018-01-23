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

  let historyTableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()

  let historyEmptyView: UIView = {
    var emptyView = UIView()
    emptyView.translatesAutoresizingMaskIntoConstraints = false
    return emptyView
  }()

  let historyEmptyImage: UIImageView = {
    let imageView = UIImageView(image: #imageLiteral(resourceName: "bulb"))
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  let historyEmptyMessage: UITextView = {
    let textView = UITextView()
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.text = "There is no history to show..."
    return textView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    // Initialize a FetchResultsController for fetching posts
    setupFetchResultsController()

    // Set the right bar button item to a plus image
    let composeButton = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .plain, target: self, action: #selector(self.compose))
    self.navigationItem.rightBarButtonItem = composeButton

    self.navigationController?.navigationBar.isTranslucent = false
    self.navigationController?.navigationBar.shadowImage = UIImage()

    self.navigationController?.navigationBar.topItem?.title = "History"
    self.navigationController?.navigationBar.prefersLargeTitles = true
    self.navigationController?.navigationItem.largeTitleDisplayMode = .never

    self.historyTableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: "HistoryTableViewCell")

    self.view.addSubview(historyTableView)
    self.view.addSubview(historyEmptyView)
    self.view.sendSubview(toBack: historyEmptyView)

    setupHistoryTableView()
    setupHistoryEmptyView()
  }

  @objc func compose(_ sender: UIBarButtonItem) {
    let composeViewController = ComposeViewController()
    let composeNavigationController = UINavigationController(rootViewController: composeViewController)
    self.present(composeNavigationController, animated: true, completion: nil)
  }

  func setupFetchResultsController() {
//    let request = NSFetchRequest(entityName: "")
  }

  func setupHistoryTableView() {
    historyTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    historyTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    historyTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    historyTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
  }

  func setupHistoryEmptyView() {

    // Constrain the historyEmptyView to the center of historyTableView
    historyEmptyView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    historyEmptyView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
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
