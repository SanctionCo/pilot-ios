//
//  HistoryViewController.swift
//  pilot
//
//  Created by Nick Eckert on 11/19/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {

  let history = [Post]() // Historical posts to display in the historyTableView

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

    self.navigationController?.navigationBar.isTranslucent = false
    self.navigationController?.navigationBar.shadowImage = UIImage()

    self.navigationController?.navigationBar.topItem?.title = "History"
    self.navigationController?.navigationBar.prefersLargeTitles = true
    self.navigationController?.navigationItem.largeTitleDisplayMode = .never

    self.historyTableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: "HistoryTableViewCell")

    self.view.addSubview(historyTableView)

    setupHistoryTableView()
  }

  func setupHistoryTableView() {
    historyTableView.addSubview(historyEmptyView)

    // Constrain table to all corners of the screen
    historyTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    historyTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    historyTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    historyTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

    //setupHistoryEmptyView()
  }

  func setupHistoryEmptyView() {
    historyEmptyView.addSubview(historyEmptyImage)
    historyEmptyView.addSubview(historyEmptyMessage)

    // Constrain the historyEmptyView to the center of historyTableView
    historyEmptyView.centerXAnchor.constraint(equalTo: historyTableView.centerXAnchor).isActive = true
    historyEmptyView.centerYAnchor.constraint(equalTo: historyTableView.centerYAnchor).isActive = true
    historyEmptyView.widthAnchor.constraint(equalToConstant: 50).isActive = true
    historyEmptyView.heightAnchor.constraint(equalToConstant: 30).isActive = true

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

extension HistoryViewController: UITableViewDataSource {
  // swiftlint:disable force_cast

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
    let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell") as! HistoryTableViewCell

    // Initialize cell state here

    return cell
  }

  // swiftlint:enable force_cast
}
