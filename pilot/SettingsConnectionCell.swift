//
//  ConnectionTableViewCell.swift
//  pilot
//
//  Created by Nick Eckert on 9/24/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import UIKit

class ConnectionTableViewCell: UITableViewCell {

  var platformImage: UIImageView = {
    let image = UIImageView()
    image.translatesAutoresizingMaskIntoConstraints = false
    image.contentMode = UIViewContentMode.scaleAspectFit
    return image
  }()

  var platformName: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  var disclosureMessage: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  var platform: Platform? {
    didSet {
      platformImage.image = platform?.image
      platformName.text = platform?.type.rawValue

      if platform!.isConnected {
        disclosureMessage.textColor = UIColor.TextRed
        disclosureMessage.text = "Disconnect"
      } else {
        disclosureMessage.text = "Connect"
      }
    }
  }

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    contentView.addSubview(platformImage)
    contentView.addSubview(platformName)
    contentView.addSubview(disclosureMessage)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    setupPlatformImage()
    setupPlatformName()
    setupDisclosureMessage()
  }

  func setupPlatformImage() {
    platformImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
    platformImage.heightAnchor.constraint(equalToConstant: 35).isActive = true
    platformImage.widthAnchor.constraint(equalToConstant: 35).isActive = true
    platformImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
  }

  func setupPlatformName() {
    platformName.leftAnchor.constraint(equalTo: platformImage.rightAnchor, constant: 10).isActive = true
    platformName.centerYAnchor.constraint(equalTo: platformImage.centerYAnchor).isActive = true
  }

  func setupDisclosureMessage() {
    disclosureMessage.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
    disclosureMessage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
  }
}
