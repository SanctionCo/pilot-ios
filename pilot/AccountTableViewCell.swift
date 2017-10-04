//
//  AccountTableViewCell.swift
//  pilot
//
//  Created by Nick Eckert on 9/24/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import UIKit

class AccountTableViewCell: UITableViewCell {

  @IBOutlet weak var accountEmail: UILabel!

  var pilotUser: PilotUser? {
    didSet {
      accountEmail.text = pilotUser?.email
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()

  }

}
