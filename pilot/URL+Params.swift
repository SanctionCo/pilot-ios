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
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: false) else { return nil }
        return components.queryItems?.first(where: { $0.name == key })?.value
    }
    
    func getFragementParam(key: String) -> String? {
        if let params = self.fragment?.components(separatedBy: "&") {
            for param in params {
                if let value = param.components(separatedBy: "=") as [String]? {
                    if value[0] == key {
                        return value[1]
                    }
                }
            }
        }
        
        return nil
    }
    
}
