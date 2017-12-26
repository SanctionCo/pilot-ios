//
//  SettingsViewController.swift
//  pilot
//
//  Created by Nick Eckert on 9/24/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

  var settingsTableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()

  var connectedPlatforms: [Platform] = []
  var unconnectedPlatforms: [Platform] = []

  override func viewDidLoad() {
    super.viewDidLoad()

    self.settingsTableView.register(ConnectionTableViewCell.self, forCellReuseIdentifier: "ConnectionTableViewCell")
    self.settingsTableView.register(AccountTableViewCell.self, forCellReuseIdentifier: "AccountTableViewCell")
    self.settingsTableView.delegate = self
    self.settingsTableView.dataSource = self

    self.navigationController?.navigationBar.isTranslucent = false
    self.navigationController?.navigationBar.shadowImage = UIImage()

    self.navigationController?.navigationBar.topItem?.title = "Settings"
    self.navigationController?.navigationBar.prefersLargeTitles = true
    self.navigationController?.navigationItem.largeTitleDisplayMode = .never

    connectedPlatforms = PlatformManager.sharedInstance.fetchConnectedPlatforms()
    unconnectedPlatforms = PlatformManager.sharedInstance.fetchUnconnectedPlatforms()

    view.addSubview(settingsTableView)

    setupSettingTableView()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.settingsTableView.reloadData()
  }

  func compose(_ sender: UIBarButtonItem) {
    if let composeNavigationController = UIStoryboard.init(name: "ComposeView", bundle: nil)
      .instantiateViewController(withIdentifier: "ComposeNavigationController") as? UINavigationController {
      self.present(composeNavigationController, animated: true, completion: nil)
    }
  }

  func setupSettingTableView() {
    settingsTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    settingsTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
  }
}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {

  // MARK: UITableViewDataSource

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // swiftlint:disable force_cast

    if indexPath.section == 0 {
      let cell = tableView.dequeueReusableCell(withIdentifier: "AccountTableViewCell") as! AccountTableViewCell

      //cell.pilotUser = pilotUser
      return cell
    } else if indexPath.section == 1 {
      let cell = tableView.dequeueReusableCell(withIdentifier: "ConnectionTableViewCell") as! ConnectionTableViewCell

      if connectedPlatforms.count != 0 {
        cell.platform = connectedPlatforms[indexPath.row]
      } else {
        cell.platform = unconnectedPlatforms[indexPath.row]
      }

      return cell
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: "ConnectionTableViewCell") as! ConnectionTableViewCell

      cell.platform = unconnectedPlatforms[indexPath.row]
      return cell
    }

    // swiftlint:enable force_cast
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
      let profileViewController = ProfileViewController()

      self.navigationController?.pushViewController(profileViewController, animated: true)
    } else if indexPath.section == 1 && connectedPlatforms.count != 0 {
      let accountViewController = AccountTableViewController()
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
