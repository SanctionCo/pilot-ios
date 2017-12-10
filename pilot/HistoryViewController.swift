//
//  HistoryViewController.swift
//  pilot
//
//  Created by Nick Eckert on 11/19/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {

  @IBOutlet weak var historyTableView: UITableView!

  let history = [Post]() // Historical posts to display in the historyTableView

  let historyEmptyView: HistoryEmptyView = {
    return HistoryEmptyView.loadFromNib()
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    // Add custom views to the view hierarchy
    view.addSubview(historyEmptyView)
    view.sendSubview(toBack: historyEmptyView)

    setupLayout()
  }

  func setupLayout() {
    // Navigation Controller style
    self.navigationController?.navigationBar.isTranslucent = false
    self.navigationController?.navigationBar.shadowImage = UIImage()

    // Constrain the EmptyTableView
    historyEmptyView.translatesAutoresizingMaskIntoConstraints = false // Disable default autolayout contraints
    historyEmptyView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    historyEmptyView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
  }

  @IBAction func compose(_ sender: UIBarButtonItem) {
    if let composeNavigationController = UIStoryboard.init(name: "ComposeView", bundle: nil)
        .instantiateViewController(withIdentifier: "ComposeNavigationController") as? UINavigationController {
      self.present(composeNavigationController, animated: true, completion: nil)
    }
  }
}

extension HistoryViewController: UITableViewDataSource {
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

  // swiftlint:disable force_cast
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell") as! HistoryTableViewCell

    // Initialize cell state here

    return cell
  }
  // swiftlint:enable force_cast
}
