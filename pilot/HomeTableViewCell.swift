//
//  ComposeTableViewCell.swift
//  pilot
//
//  Created by Nick Eckert on 7/28/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell, HomeTableViewCellDelegate {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var platformImage: UIImageView?
    @IBOutlet weak var progressBar: UIProgressView!
    
    var platform: Platform! {
        didSet {
            title.text = platform.type.rawValue
            platformImage?.image = platform.image
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        progressBar.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Custom cell animations/UI when selected
    }
    
    func setProgress(value: Double) {
        progressBar.progress = Float(value)
    }
    
    func showProgressBar() {
        progressBar.isHidden = false
    }
    
    func hideProgressBar() {
        progressBar.isHidden = true
    }
    
}
