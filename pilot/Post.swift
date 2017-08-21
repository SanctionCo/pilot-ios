//
//  Post.swift
//  pilot
//
//  Created by Nick Eckert on 8/9/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation
import UIKit

// Represents data that a user wishes to upload to a platform

struct Post: Equatable {
    
    var text = ""        // Default empty string
    var image: UIImage?
    var postType: PostType
    
    init(text: String?, image: UIImage?, postType: PostType) {
        if let text = text {
            self.text = text
        }
        
        if let image = image {
            self.image = image
        }
        
        self.postType = postType
    }
    
}

func == (left: Post, right: Post) -> Bool {
    return left.text.hashValue == right.text.hashValue && left.image?.hashValue == right.image?.hashValue
}
