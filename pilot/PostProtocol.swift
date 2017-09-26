//
//  PostProtocol.swift
//  pilot
//
//  Created by Nick Eckert on 8/11/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation

enum PostType: String {
    case photo = "photo"
    case video = "video"
    case text = "text"
}

protocol PostProtocol {
    
    var type: PostType { get }
    
}

extension PostProtocol {
    
    var description: String {
        return "Post{name=\(type.rawValue)}"
    }
    
    func isEqual(_ object: Any?) -> Bool {
        if let obj = object as? PostProtocol {
            return self.type == obj.type
        }
        
        return false
    }
    
}
