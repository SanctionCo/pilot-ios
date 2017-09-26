//
//  ConnectionTableViewCell.swift
//  pilot
//
//  Created by Nick Eckert on 9/24/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import UIKit

class ConnectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var platformImage: UIImageView!
    @IBOutlet weak var platformName: UILabel!
    
    var platform: Platform? {
        didSet {
            platformImage.image = platform?.image
            platformName.text = platform?.type.rawValue
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
