//
//  SelectionCell.swift
//  pilot
//
//  Created by Nick Eckert on 1/26/18.
//  Copyright © 2018 sanction. All rights reserved.
//

import UIKit

class SelectionCell: UITableViewCell {

  private var radioButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(#imageLiteral(resourceName: "Unselected"), for: .normal)
    return button
  }()

  private var platformName: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
    }()

  var title: String? {
    didSet {
      platformName.text = title
    }
  }

  override var isSelected: Bool {
    didSet {
      radioButton.setImage(isSelected ? #imageLiteral(resourceName: "Selected") : #imageLiteral(resourceName: "Unselected"), for: .normal)
    }
  }

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    selectionStyle = UITableViewCellSelectionStyle.none

    contentView.addSubview(radioButton)
    contentView.addSubview(platformName)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    setupRadioButton()
    setupPlatformName()
  }

  private func setupRadioButton() {
    radioButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
    radioButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    radioButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    radioButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
  }

  private func setupPlatformName() {
    platformName.leftAnchor.constraint(equalTo: radioButton.rightAnchor, constant: 10).isActive = true
    platformName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
  }
}
