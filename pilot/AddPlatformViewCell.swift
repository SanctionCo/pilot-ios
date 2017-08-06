//
//  AddPlatformViewCellTableViewCell.swift
//  pilot
//
//  Created by Nick Eckert on 7/27/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import UIKit

class AddPlatformViewCell: UITableViewCell {

    @IBOutlet weak var platformImage: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var platformViewModel: PlatformViewModel! {
        didSet {
            platformImage.image = platformViewModel.image
            label.text = platformViewModel.name
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
