//
//  HomeTabBarController.swift
//  pilot
//
//  Created by Nick Eckert on 11/19/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import UIKit

class HomeTabBarController: UITabBarController, UITabBarControllerDelegate {

  override func viewDidLoad() {
    self.delegate = self
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    setupTabBar()

    let postsViewController = PostsViewController()
    postsViewController.tabBarItem =
      UITabBarItem(title: "Posts", image: #imageLiteral(resourceName: "PostcardGray"), selectedImage: #imageLiteral(resourceName: "PostcardPilotBlue"))
    let postsNavigationController = UINavigationController(rootViewController: postsViewController)

    let settingsViewController = SettingsViewController()
    settingsViewController.tabBarItem =
      UITabBarItem(title: "Settings", image: #imageLiteral(resourceName: "SettingsGray"), selectedImage: #imageLiteral(resourceName: "SettingsPilotBlue"))
    let settingsNavigationController = UINavigationController(rootViewController: settingsViewController)

    // Place the viewControllers in a list for the tabBarController to access
    self.viewControllers = [postsNavigationController, settingsNavigationController]
  }

  private func setupTabBar() {
    self.tabBar.isTranslucent = false
    self.tabBar.backgroundColor = UIColor.white
  }
}
