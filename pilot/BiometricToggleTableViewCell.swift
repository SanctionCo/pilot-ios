//
//  BiometricToggleTableViewCell.swift
//  pilot
//
//  Created by Rohan Nagar on 1/18/18.
//  Copyright © 2018 sanction. All rights reserved.
//

import UIKit

class BiometricToggleTableViewCell: UITableViewCell {
  var toggle: UISwitch = {
    let toggle = UISwitch()

    toggle.addTarget(self, action: #selector(handleSwitchAction), for: .valueChanged)

    return toggle
  }()

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    contentView.addSubview(toggle)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    setupToggle()
  }

  @objc private func handleSwitchAction() {
    print("switch")
    if toggle.isOn {
      UserDefaults.standard.set(true, forKey: "biometrics")
    } else {
      UserDefaults.standard.set(false, forKey: "biometrics")
    }
  }

  func setupToggle() {
    if UserDefaults.standard.bool(forKey: "biometrics") {
      toggle.isOn = true
    }
  }
}
