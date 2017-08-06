//
//  FileService.swift
//  pilot
//
//  Created by Nick Eckert on 7/26/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation
import Alamofire

enum FileType: String {
    case text = "text"
    case photo = "photo"
    case video = "video"
}

protocol FileService {
    var pilotUser: PilotUser! { get set }
    var basicCredentials: String { get }
    
    init(pilotUser: PilotUser)
}

extension FileService {
    
    func upload(text: String, image: UIImage, to url: String) {
        // Build the authorization headers for the request
//        let headers = ["Authorization": "Basic \(basicCredentials)",
//            "password": "\(pilotUser.password)"]
//        
//        let fileURL = Bundle.main.url(forResource: "video", withExtension: "mov")
        
        
//        Alamofire.upload(
//            multipartFormData: { multipartFormData in
//                multipartFormData.append("", withName: "file")
//            },
//            to: "\(url)?email=\(pilotUser.email)&type=\(type)",
//            headers: headers,
//            encodingCompletion: { encodingResult in
//                switch encodingResult {
//                case .success(let upload, _, _):
//                    upload.responseString { response in
//                        debugPrint(response)
//                    }
//                case .failure(let encodingError):
//                    print(encodingError)
//                }
//            }
//        )
    }
    
}
