//
//  SettingsViewController.swift
//  pilot
//
//  Created by Nick Eckert on 9/24/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
  let authenticationHelper = AuthenticationHelper()

  var settingsTableView: UITableView = {
    let tableView = UITableView(frame: CGRect.zero, style: .grouped)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()

  var biometricsSwitch: UISwitch = {
    let biometricsSwitch = UISwitch()
    biometricsSwitch.addTarget(self, action: #selector(handleSwitchAction), for: .valueChanged)

    if UserDefaults.standard.bool(forKey: "biometrics") {
      biometricsSwitch.setOn(true, animated: false)
    } else {
      biometricsSwitch.setOn(false, animated: false)
    }

    return biometricsSwitch
  }()

  var connectedPlatforms: [Platform] = []
  var unconnectedPlatforms: [Platform] = []

  override func viewDidLoad() {
    super.viewDidLoad()

    self.settingsTableView.register(ConnectionTableViewCell.self, forCellReuseIdentifier: "ConnectionTableViewCell")
    self.settingsTableView.register(AccountTableViewCell.self, forCellReuseIdentifier: "AccountTableViewCell")
    self.settingsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "BiometricsTableViewCell")

    self.settingsTableView.delegate = self
    self.settingsTableView.dataSource = self

    // Set the right bar button item to a plus image
    let composeButton = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .plain, target: self, action: #selector(self.compose))
    self.navigationItem.rightBarButtonItem = composeButton

    self.navigationController?.navigationBar.isTranslucent = false
    self.navigationController?.navigationBar.shadowImage = UIImage()

    self.navigationController?.navigationBar.topItem?.title = "Settings"
    self.navigationController?.navigationBar.prefersLargeTitles = true
    self.navigationController?.navigationItem.largeTitleDisplayMode = .never

    connectedPlatforms = PlatformManager.sharedInstance.fetchConnectedPlatforms()
    unconnectedPlatforms = PlatformManager.sharedInstance.fetchUnconnectedPlatforms()

    view.addSubview(settingsTableView)

    setupSettingsTableView()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.settingsTableView.reloadData()
  }

  @objc func compose(_ sender: UIBarButtonItem) {
    let composeViewController = ComposeViewController()
    let composeNavigationController = UINavigationController(rootViewController: composeViewController)
    self.present(composeNavigationController, animated: true, completion: nil)
  }

  @objc private func handleSwitchAction() {
    if biometricsSwitch.isOn {
      UserDefaults.standard.set(true, forKey: "biometrics")
    } else {
      UserDefaults.standard.set(false, forKey: "biometrics")
    }
  }

  func setupSettingsTableView() {
    settingsTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    settingsTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    settingsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    settingsTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
  }
}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {

  // MARK: UITableViewDataSource

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // swiftlint:disable force_cast

    if indexPath.section == 0 {
      let cell = tableView.dequeueReusableCell(withIdentifier: "AccountTableViewCell") as! AccountTableViewCell
      cell.email = UserManager.sharedInstance?.getEmail()

      return cell
    } else if indexPath.section == 1 {
      if authenticationHelper.canUseBiometrics() {
        // Add biometrics section if the device can use it
        let cell = tableView.dequeueReusableCell(withIdentifier: "BiometricsTableViewCell")!
        cell.textLabel?.text = "Login with " + authenticationHelper.biometricType().rawValue
        cell.accessoryView = biometricsSwitch

        return cell
      } else {
        // Otherwise add the appropriate platform section
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConnectionTableViewCell") as! ConnectionTableViewCell

        if connectedPlatforms.count != 0 {
          cell.platform = connectedPlatforms[indexPath.row]
        } else {
          cell.platform = unconnectedPlatforms[indexPath.row]
        }

        return cell
      }
    } else if indexPath.section == 2 {
      let cell = tableView.dequeueReusableCell(withIdentifier: "ConnectionTableViewCell") as! ConnectionTableViewCell

      if authenticationHelper.canUseBiometrics() && connectedPlatforms.count != 0 {
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
      if authenticationHelper.canUseBiometrics() {
        return ""
      } else if connectedPlatforms.count != 0 {
        return "Connected Accounts"
      } else {
        return "Available Platforms"
      }
    } else if section == 2 {
      if authenticationHelper.canUseBiometrics() && connectedPlatforms.count != 0 {
        return "Connected Accounts"
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

    if connectedCount == 0 && unconnectedCount == 0 && !authenticationHelper.canUseBiometrics() {
      return 1
    } else if connectedCount == 0 && unconnectedCount == 0 && authenticationHelper.canUseBiometrics() {
      return 2
    } else if connectedCount != 0 && unconnectedCount != 0 && !authenticationHelper.canUseBiometrics() {
      return 3
    } else {
      return 4
    }
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return 1
    } else if section == 1 {
      if authenticationHelper.canUseBiometrics() {
        return 1
      } else if connectedPlatforms.count != 0 {
        return connectedPlatforms.count
      } else {
        return unconnectedPlatforms.count
      }
    } else if section == 2 {
      if authenticationHelper.canUseBiometrics() && connectedPlatforms.count != 0 {
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
    } else if indexPath.section == 1 && authenticationHelper.canUseBiometrics() {
      // Biometrics switch - do nothing
    } else if (indexPath.section == 1 && !authenticationHelper.canUseBiometrics() && connectedPlatforms.count != 0)
              || (indexPath.section == 2 && authenticationHelper.canUseBiometrics() && connectedPlatforms.count != 0) {
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
