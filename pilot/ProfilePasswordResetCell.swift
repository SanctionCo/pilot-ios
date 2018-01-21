//
//  ProfilePasswordResetCell.swift
//  pilot
//
//  Created by Nick Eckert on 12/30/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation
import UIKit

class ProfilePasswordResetCell: UITableViewCell {

  var resetMessage: UILabel = {
    let message = UILabel()
    message.translatesAutoresizingMaskIntoConstraints = false
    message.text = "Password Reset"
    return message
  }()

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    contentView.addSubview(resetMessage)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    setupResetMessage()
  }

  func setupResetMessage() {
    resetMessage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    resetMessage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
  }
}
