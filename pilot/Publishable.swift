//
//  Publishable.swift
//  pilot
//
//  Created by Nick Eckert on 8/28/17.
//  Copyright © 2017 sanction. All rights reserved.
//


import Foundation
import Alamofire
import AVFoundation

// The publishable protocol allows an object to be published through lightning's publish endpoint.
protocol Publishable {
  
}


extension Publishable {
  
  typealias SuccessHandler = () -> Void
  typealias ErrorHandler = (Error) -> Void
  typealias ProgressHandler = (Double) -> Void
  
  static func publish(post: Post,
                      with request: URLRequestConvertible,
                      onProgress: @escaping ProgressHandler,
                      onSuccess: @escaping SuccessHandler,
                      onError: @escaping ErrorHandler) {
    
    NetworkManager.sharedInstance.upload(multipartFormData: { multipartFormData in
      switch post.postType {
      case .photo:
        // Encode an image into the request
        if let image = post.thumbNailImage, let imageData = UIImageJPEGRepresentation(image, 1) {
          multipartFormData.append(imageData, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")
        }
        
      case .video:
        // Encode a video into the request
        
        // Because a video can exceed memory limits a file URL is used instead
        guard let fileURL = post.fileURL else { return }
        
        multipartFormData.append(fileURL, withName: "file", fileName: "video.mov", mimeType: "video/quicktime")
        
      case .text:
        // Encode an empty string into the request
        
        multipartFormData.append("".data(using: .utf8)!, withName: "file")
        
      }
    }, with: request, encodingCompletion: { encodingResult in
      switch encodingResult {
      case .success(let uploadRequest, _, _):
        uploadRequest.uploadProgress { progress in
          let percentage = progress.fractionCompleted
          onProgress(percentage)
          }.responseJSON() { response in
            debugPrint(response)
            switch response.result {
            case .success:
              onSuccess()
            case .failure(let error):
              onError(error)
            }
        }
      case .failure(let encodingError):
        onError(encodingError)
      }
    })
    
  }
  
}
