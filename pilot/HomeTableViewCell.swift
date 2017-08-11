//
//  ComposeTableViewCell.swift
//  pilot
//
//  Created by Nick Eckert on 7/28/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import UIKit

class ComposeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var platformImage: UIImageView?
    
    var platform: Platform! {
        didSet {
            title.text = platform.type.rawValue
            platformImage?.image = platform.image
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Custom cell animations/UI when selected
    }
    
}
