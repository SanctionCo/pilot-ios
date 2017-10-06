//
//  OAuthManager.swift
//  pilot
//
//  Created by Nick Eckert on 9/30/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation
import SafariServices

class OAuthManager {

  static var authSession: SFAuthenticationSession?

  typealias SuccessHandler = () -> Void
  typealias ErrorHandler = (Error) -> Void

  static func authorizeService(platform: Platform,
                               onSuccess: @escaping SuccessHandler,
                               onError: @escaping ErrorHandler) {

    NetworkManager.sharedInstance.request(LightningRouter.getOauthURL(platform.type)).responseString { response in

      debugPrint(response)
      switch response.result {
      case .success(let value):

        guard let authURL = URL(string: value) else {
          return
        }

        OAuthManager.authSession =
          SFAuthenticationSession(url: authURL,
                                  callbackURLScheme: platform.redirectURL) { (callBack: URL?, error: Error?) in

          guard error == nil, let successURL = callBack else {
            if let error = error {
              onError(error)
            }

            return
          }

          switch platform.type {
          case .facebook:
            let token = successURL.getFragementParam(key: platform.tokenParamKey)

            UserManager.sharedInstance?.setFacebookAccessToken(token: token!)
          default:
            break
          }

          UserManager.sharedInstance?.updateUser(onSuccess: { _ in
            onSuccess()
          }, onError: { error in
            debugPrint(error)
          })

        }

        OAuthManager.authSession?.start()

      case .failure(let error):
        onError(error)
      }

    }

  }

}
