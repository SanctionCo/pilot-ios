//
//  AccountTableViewCell.swift
//  pilot
//
//  Created by Nick Eckert on 9/24/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import UIKit

class AccountTableViewCell: UITableViewCell {

  private var accountEmail: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  var email: String? {
    didSet {
      accountEmail.text = email
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
    accountEmail.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
    accountEmail.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
  }
}
