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
    
  }

}

extension HomeTabBarController: UITabBarControllerDelegate {

  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    // TabBar item was selected with a viewController
  }

}
