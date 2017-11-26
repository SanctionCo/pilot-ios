//
//  HistoryEmptyView.swift
//  pilot
//
//  Created by Nick Eckert on 11/25/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import UIKit

class HistoryEmptyView: UIView {

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  // swiftlint:disable force_cast
  class func loadFromNib() -> HistoryEmptyView {
    return Bundle.main.loadNibNamed("HistoryEmptyView", owner: self, options: nil)?.first as! HistoryEmptyView
  }
  // swiftlint:enable force_cast
}
