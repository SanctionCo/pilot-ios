//
//  ProfileSingoutCell.swift
//  pilot
//
//  Created by Nick Eckert on 12/30/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation
import UIKit

class ProfileSignoutCell: UITableViewCell {

  var signoutMessage: UILabel = {
    let message = UILabel()
    message.translatesAutoresizingMaskIntoConstraints = false
    message.text = "Signout"
    return message
  }()

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    contentView.addSubview(signoutMessage)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    setupSignoutMessage()
  }

  func setupSignoutMessage() {
    signoutMessage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    signoutMessage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
  }
}
