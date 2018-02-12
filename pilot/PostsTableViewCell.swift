//
//  HistoryTableViewCell.swift
//  pilot
//
//  Created by Nick Eckert on 12/27/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import UIKit

class PostsTableViewCell: UITableViewCell {

  private var postIcon: UIImageView = {
    let icon = UIImageView()
    icon.translatesAutoresizingMaskIntoConstraints = false
    icon.contentMode = UIViewContentMode.scaleAspectFit
    return icon
  }()

  private var postText: UILabel = {
    let text = UILabel()
    text.translatesAutoresizingMaskIntoConstraints = false
    text.adjustsFontSizeToFitWidth = true
    text.lineBreakMode = NSLineBreakMode.byTruncatingTail
    text.sizeToFit()
    return text
  }()

  private var postDate: UILabel = {
    let date = UILabel()
    date.translatesAutoresizingMaskIntoConstraints = false
    date.adjustsFontSizeToFitWidth = true
    date.textColor = UIColor.TextGray
    date.font = date.font.withSize(13)
    date.numberOfLines = 1
    date.lineBreakMode = .byClipping
    date.minimumScaleFactor = 0.1
    date.sizeToFit()
    return date
  }()

  private var postTime: UILabel = {
    let time = UILabel()
    time.translatesAutoresizingMaskIntoConstraints = false
    time.textColor = UIColor.TextGray
    time.font = time.font.withSize(13)
    time.numberOfLines = 1
    time.lineBreakMode = .byClipping
    time.minimumScaleFactor = 0.1
    time.sizeToFit()
    return time
  }()

  var icon: UIImage? {
    didSet {
      self.postIcon.image = icon
    }
  }

  var message: String? {
    didSet {
      self.postText.text = message
    }
  }

  var date: String? {
    didSet {
      self.postDate.text = date
    }
  }

  var time: String? {
    didSet {
      self.postTime.text = time
    }
  }

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    contentView.addSubview(postIcon)
    contentView.addSubview(postText)
    contentView.addSubview(postDate)
    contentView.addSubview(postTime)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    setupPost()
  }

  private func setupPost() {

    // Pin icon to the left of the cell
    postIcon.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
    postIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    postIcon.heightAnchor.constraint(equalToConstant: 40).isActive = true
    postIcon.widthAnchor.constraint(equalToConstant: 40).isActive = true

    // Attach the post text to the top
    postText.leftAnchor.constraint(equalTo: postIcon.rightAnchor, constant: 20).isActive = true
    postText.topAnchor.constraint(equalTo: postIcon.topAnchor).isActive = true

    // Attach date below text
    postDate.leftAnchor.constraint(equalTo: postIcon.rightAnchor, constant: 20).isActive = true
    postDate.bottomAnchor.constraint(equalTo: postIcon.bottomAnchor).isActive = true

    // Attach the post time below the text on the right
    postTime.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
    postTime.bottomAnchor.constraint(equalTo: postIcon.bottomAnchor).isActive = true
  }
}
