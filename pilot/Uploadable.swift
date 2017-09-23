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
import SwiftyJSON

// The uploadable protocol will allow an object to be uploaded to lightning as a JSON object.
// (mainly for a PilotUser object to update/create a new user)
protocol Uploadable {
    
}


extension Uploadable where Self: Mappable {
    
    typealias SuccessHandler = () -> Void
    typealias ErrorHandler = (Error) -> Void
    
    static func upload(with request: URLRequestConvertible, onSuccess: @escaping SuccessHandler, onError: @escaping ErrorHandler) {
        
        NetworkManager.sharedInstance.request(request).responseString() { response in
            switch response.result {
            case .success:
                debugPrint(response)
                onSuccess()
            case .failure(let error):
                onError(error)
            }
        }
        
    }
    
}
