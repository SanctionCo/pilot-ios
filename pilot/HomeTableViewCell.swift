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
    @IBOutlet weak var platformImage: UIImageView!
    
    var platformViewModel: PlatformViewModel? {
        didSet {
            title.text = platformViewModel?.name
            
            if let image = platformViewModel?.image {
                platformImage.image = image
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
