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
  @IBOutlet var historyEmptyView: UIView!

  let history = [Post]() // Historical posts to display in the historyTableView

  override func viewDidLoad() {
      super.viewDidLoad()

      // Load the custom emptyTableView
      if let historyEmptyView =
        Bundle.main.loadNibNamed("HistoryEmptyView", owner: self, options: nil)?.first as? UIView {

        historyEmptyView.center = CGPoint.init(x: self.view.frame.midX, y: self.view.frame.midY)

        // Place the view behind the tableView
        self.view.addSubview(historyEmptyView)
        self.view.sendSubview(toBack: historyEmptyView)
      }

      styleUI()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }

  func styleUI() {
    self.navigationController?.navigationBar.isTranslucent = false
    self.navigationController?.navigationBar.shadowImage = UIImage()
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
