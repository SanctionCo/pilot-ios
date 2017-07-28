//
//  SelectionTableViewCell.swift
//  pilot
//
//  Created by Nick Eckert on 7/23/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import UIKit

class SelectionTableViewCell: UITableViewCell {

    @IBOutlet weak var cellSwitch: UISwitch!
    @IBOutlet weak var cellLabel: UILabel!
    
    var platformViewModel: PlatformViewModel! {
        didSet {
            cellLabel.text = platformViewModel.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
