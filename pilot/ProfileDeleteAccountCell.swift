//
//  ProfileDeleteAccountCell.swift
//  pilot
//
//  Created by Nick Eckert on 12/30/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation
import UIKit

class ProfileDeleteAccountCell: UITableViewCell {

  var deleteAccountMessage: UILabel = {
    let message = UILabel()
    message.translatesAutoresizingMaskIntoConstraints = false
    message.text = "Delete Account"
    message.textColor = UIColor.TextWhite
    return message
  }()

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    contentView.backgroundColor = UIColor.ButtonRed
    contentView.addSubview(deleteAccountMessage)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    setupDeleteAccountMessage()
  }

  func setupDeleteAccountMessage() {
    deleteAccountMessage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    deleteAccountMessage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
  }
}
