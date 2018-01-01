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
    resetMessage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
    resetMessage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
    resetMessage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    resetMessage.heightAnchor.constraint(equalToConstant: 30).isActive = true
    resetMessage.widthAnchor.constraint(equalToConstant: 80).isActive = true
  }
}
