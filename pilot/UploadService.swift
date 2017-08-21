//
//  FileService.swift
//  pilot
//
//  Created by Nick Eckert on 7/26/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import HTTPStatusCodes

struct UploadService {
    
    let sessionManager = SessionManager()
    
    init(pilotUser: PilotUser) {
        sessionManager.adapter = AuthAdapter(pilotUser: pilotUser)
    }
    
    /// Uploads a post to lightning
    ///
    /// - Parameter post: User Post object representing a user post
    /// - Parameter platformType: Platform type the user is uploading to
    func upload(post: Post, to platformType: PlatformType, completion: @escaping () -> ()) {
        
        // Create the parameters based on the provided post
        let queryParams = [
            "type": post.postType.rawValue,
            "message": post.text
        ]
        
        sessionManager.upload(multipartFormData: { multipartFormData in
            
            if let image = post.image {
                if let imageData = UIImageJPEGRepresentation(image, 1) {
                    multipartFormData.append(imageData, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")
                }
            }
            
        }, with: LightningRouter.publish(platformType, queryParams), encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseString() { response in
                    completion()
                    debugPrint(response)
                }
            case .failure(let encodingError):
                completion()
                print(encodingError)
            }
            
        })
    }
    
}
