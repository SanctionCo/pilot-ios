//
//  URL+Params.swift
//  pilot
//
//  Created by Nick Eckert on 9/22/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation

extension URL {
    
    func getQueryParam(key: String) -> String? {
        guard let components = URLComponents(string: self.absoluteString) else { return nil }
        return components.queryItems?.first(where: { $0.name == key })?.value
    }
    
}
