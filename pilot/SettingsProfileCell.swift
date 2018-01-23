//
//  SettingsProfileCell.swift
//  pilot
//
//  Created by Nick Eckert on 1/20/18.
//  Copyright © 2018 sanction. All rights reserved.
//

import UIKit

class SettingsProfileCell: UITableViewCell {

  private var profileImage: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = UIViewContentMode.scaleAspectFit
    return imageView
  }()

  private var profileEmail: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  var cellProfileImage: UIImage? {
    didSet {
      profileImage.image = cellProfileImage
    }
  }

  var cellProfileEmail: String? {
    didSet {
      profileEmail.text = cellProfileEmail
    }
  }

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    contentView.addSubview(profileImage)
    contentView.addSubview(profileEmail)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    setupProfileImage()
    setupProfileEmail()
  }

  private func setupProfileImage() {
    profileImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
    profileImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    profileImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
    profileImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
  }

  private func setupProfileEmail() {
    profileEmail.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 10).isActive = true
    profileEmail.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
  }
}
