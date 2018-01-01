//
//  AccountDisconnectionCell.swift
//  pilot
//
//  Created by Nick Eckert on 12/30/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import UIKit

class AccountDisconnectionCell: UITableViewCell {

  private var disconnectionText: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Disconnect"
    label.textColor = UIColor.TextRed
    return label
  }()

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    contentView.addSubview(disconnectionText)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    setupDisconnectionText()
  }

  private func setupDisconnectionText() {
    disconnectionText.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    disconnectionText.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
  }
}
