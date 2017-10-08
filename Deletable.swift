//
//  Deletable.swift
//  pilot
//
//  Created by Nick Eckert on 10/4/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper
import Foundation
import ObjectMapper

// The deletable protocol will allow an object to be deleted from Thunder.
protocol Deletable {

}

extension Deletable where Self: Mappable {

  typealias SuccessHandler<T> = (T) -> Void where T: Mappable
  typealias ErrorHandler = (Error) -> Void

  static func delete(with request: URLRequestConvertible,
                     onSuccess: @escaping SuccessHandler<Self>,
                     onError: @escaping ErrorHandler) {

    NetworkManager.sharedInstance.request(request).responseObject { (response: DataResponse<Self>) in
      debugPrint(response)
      switch response.result {
      case .success:
        if let responseObject: Self = response.result.value {
          onSuccess(responseObject)
        }
      case .failure(let error):
        onError(error)
      }

    }

  }
}
