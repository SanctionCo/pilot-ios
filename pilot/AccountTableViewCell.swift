//
//  AccountTableViewCell.swift
//  pilot
//
//  Created by Nick Eckert on 9/24/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import UIKit

class AccountTableViewCell: UITableViewCell {

  var accountEmail: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  var pilotUser: PilotUser? {
    didSet {
      accountEmail.text = pilotUser?.email
    }
  }

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    contentView.addSubview(accountEmail)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    setupAccountEmail()
  }

  private func setupAccountEmail() {
    
  }
}
