//
//  HomeTabBarController.swift
//  pilot
//
//  Created by Nick Eckert on 11/19/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import UIKit

class HomeTabBarController: UITabBarController {

  override func viewDidLoad() {
    self.delegate = self
  }

  override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    let historyViewController = HistoryViewController()
    historyViewController.tabBarItem = UITabBarItem(title: "History", image: UIImage(named: "Clock"), selectedImage: UIImage(named: "ClockFilled"))

    let settingsViewController = SettingsViewController()
    settingsViewController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "Menu"), selectedImage: UIImage(named: "Menu"))

    // Place the viewControllers in a list for the tabBarController to access
    let viewControllerList = [historyViewController, settingsViewController]

    self.tabBarController?.viewControllers = viewControllerList
  }
}

extension HomeTabBarController: UITabBarControllerDelegate {

}
