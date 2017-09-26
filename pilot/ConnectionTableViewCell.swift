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
    @IBOutlet weak var disclosureMessage: UILabel!
    
    var platform: Platform? {
        didSet {
            platformImage.image = platform?.image
            platformName.text = platform?.type.rawValue
            
            if platform!.isConnected {
                disclosureMessage.textColor = UIColor.TextRed
                disclosureMessage.text = "Disconnect"
            } else {
                disclosureMessage.text = "Connect"
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
