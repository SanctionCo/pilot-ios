//
//  Uploadable.swift
//  pilot
//
//  Created by Nick Eckert on 8/28/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import SwiftyJSON

// The uploadable protocol will allow an object to be uploaded to lightning as a JSON object.
// (mainly for a PilotUser object to update/create a new user)
protocol Uploadable {
    
}


extension Uploadable where Self: Mappable {
    
    typealias SuccessHandler = () -> Void
    typealias ErrorHandler = (Error) -> Void
    
    static func upload(object: Self, with request: URLRequestConvertible, onSuccess: @escaping SuccessHandler, onError: @escaping ErrorHandler) {
        
        let jsonString = object.toJSONString()
        let data = jsonString?.data(using: .utf8)
        
        NetworkManager.sharedInstance.upload(data!, with: request).responseJSON() { response in
            switch response.result {
            case .success:
                onSuccess()
            case .failure(let error):
                onError(error)
            }
        }
    }
    
}
