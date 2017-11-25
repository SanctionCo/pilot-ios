//
//  SettingsViewController.swift
//  pilot
//
//  Created by Nick Eckert on 9/24/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!

  var pilotUser: PilotUser =
    PilotUser(email: UserManager.sharedInstance!.getEmail(), password: UserManager.sharedInstance!.getPassword())
  var connectedPlatforms: [Platform] = []
  var unconnectedPlatforms: [Platform] = []

  override func viewDidLoad() {
    super.viewDidLoad()

    self.navigationController?.navigationItem.largeTitleDisplayMode = .never

    styleUI()
    loadUI()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.tableView.reloadData()
  }

  func styleUI() {
    self.navigationController?.navigationBar.isTranslucent = false
    self.navigationController?.navigationBar.shadowImage = UIImage()
  }

  func loadUI() {
    connectedPlatforms = PlatformManager.sharedInstance.fetchConnectedPlatforms()
    unconnectedPlatforms = PlatformManager.sharedInstance.fetchUnconnectedPlatforms()
  }

  @IBAction func compose(_ sender: UIBarButtonItem) {
    if let composeNavigationController = UIStoryboard.init(name: "ComposeView", bundle: nil)
      .instantiateViewController(withIdentifier: "ComposeNavigationController") as? UINavigationController {
      self.present(composeNavigationController, animated: true, completion: nil)
    }
  }
}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {

  // MARK: UITableViewDataSource

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 0 {

      // swiftlint:disable force_cast
      let cell =
        tableView.dequeueReusableCell(withIdentifier: "AccountTableViewCell", for: indexPath) as! AccountTableViewCell
      // swiftlint:enable force_cast

      cell.pilotUser = pilotUser
      return cell
    } else if indexPath.section == 1 {

      // swiftlint:disable force_cast
      let cell = tableView
        .dequeueReusableCell(withIdentifier: "ConnectionTableViewCell", for: indexPath) as! ConnectionTableViewCell
      // swiftlint:enable force_cast

      if connectedPlatforms.count != 0 {
        cell.platform = connectedPlatforms[indexPath.row]
      } else {
        cell.platform = unconnectedPlatforms[indexPath.row]
      }

      return cell
    } else {

      // swiftlint:disable force_cast
      let cell = tableView
        .dequeueReusableCell(withIdentifier: "ConnectionTableViewCell", for: indexPath) as! ConnectionTableViewCell
      // swiftlint:enable force_cast

      cell.platform = unconnectedPlatforms[indexPath.row]
      return cell
    }
  }

  // MARK: UITableViewDelegate

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if section == 0 {
      return ""
    } else if section == 1 {
      if connectedPlatforms.count != 0 {
        return "ConnectedAccounts"
      } else {
        return "Available Platforms"
      }
    } else {
      return "Available Platforms"
    }
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    let connectedCount = connectedPlatforms.count
    let unconnectedCount = unconnectedPlatforms.count

    if connectedCount == 0 && unconnectedCount == 0 {
      return 1
    } else if connectedCount != 0 && unconnectedCount != 0 {
      return 3
    } else {
      return 2
    }
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return 1
    } else if section == 1 {
      if connectedPlatforms.count != 0 {
        return connectedPlatforms.count
      } else {
        return unconnectedPlatforms.count
      }
    } else {
      return unconnectedPlatforms.count
    }
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    if indexPath.section == 0 {

      // swiftlint:disable force_cast
      let profileViewController =
        storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
      // swiftlint:enable force_cast

      self.navigationController?.pushViewController(profileViewController, animated: true)
    } else if indexPath.section == 1 && connectedPlatforms.count != 0 {

      // swiftlint:disable force_cast
      let accountViewController = storyboard?
        .instantiateViewController(withIdentifier: "AccountTableViewController") as! AccountTableViewController
      // swiftlint:enable force_cast

      accountViewController.platform = connectedPlatforms[indexPath.row]

      self.navigationController?.pushViewController(accountViewController, animated: true)
    } else {
      let platform = unconnectedPlatforms[indexPath.row]

      OAuthManager.authorizeService(platform: platform, onSuccess: {
        PlatformManager.sharedInstance.reload()

        self.navigationController?.popViewController(animated: true)
      }, onError: { error in
        debugPrint(error)
      })

    }

  }

}
