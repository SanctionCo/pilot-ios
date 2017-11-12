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

  typealias AuthorizeSuccessHandler = () -> Void
  typealias ErrorHandler = (Error) -> Void

  static func authorizeService(platform: Platform,
                               onSuccess: @escaping AuthorizeSuccessHandler,
                               onError: @escaping ErrorHandler) {

    OAuthRequest.fetch(with: LightningRouter.getOauthURL(platform.type), onSuccess: { authRequest in
      guard  let requestUrlString = authRequest.url,
        let requestUrl = URL(string: requestUrlString) else {
          return
      }

      OAuthManager.authSession = SFAuthenticationSession(url: requestUrl,
                                                         callbackURLScheme: platform.redirectURL) {
                                                          (callBack: URL?, error: Error?) in
        guard error == nil, let successURL = callBack else {
          if let error = error {
            onError(error)
          }

          return
        }

        // Perform any additional steps if nessissary to get the final tokens!
        exchangeToken(platformType: platform.type,
                      successURL: successURL,
                      authRequest: authRequest,
                      onSuccess: { finalRequest in
          // Update the user based on the platform
          switch platform.type {
          case .facebook:
            UserManager.sharedInstance?.setFacebookAccessToken(token: finalRequest.accessToken)
          case .twitter:
            UserManager.sharedInstance?.setTwitterAccessToken(token: finalRequest.accessToken)
            UserManager.sharedInstance?.setTwitterAccessSecret(secret: finalRequest.accessSecret)
          }

          UserManager.sharedInstance?.updateUser(onSuccess: { _ in
            onSuccess()
          }, onError: { error in
            onError(error)
          })
        }, onError: { error in
          onError(error)
        })

      }

      OAuthManager.authSession?.start()
    }, onError: { error in
      onError(error)
    })
  }

  typealias TokenSuccessHandler = (OAuthResult) -> Void

  /// Exchanges the base token from the initial request and does any additional steps to get the final token.
  ///
  /// - Parameters:
  ///   - authRequest: Information from the call to Lightning
  ///   - onSuccess: Success handler
  ///   - onError: Error handler
  static func exchangeToken(platformType: PlatformType,
                            successURL: URL, authRequest: OAuthRequest,
                            onSuccess: @escaping TokenSuccessHandler,
                            onError: @escaping ErrorHandler) {
    switch platformType {
    case .facebook:
      guard let token = successURL.getFragementParam(key: PilotConfiguration.Lightning.facebookTokenParamKey) else { return }

      onSuccess(OAuthResult(accessToken: token, accessSecret: nil))
    case .twitter:
      guard let requestToken = authRequest.requestToken,
            let requestSecret = authRequest.requestSecret,
            let verifier = successURL.getQueryParam(key: PilotConfiguration.Lightning.twitterVerifierParamKey) else {
          return
      }

      // Build the request params
      let parameters = ["oauth_verifier": verifier,
                        "oauth_request_token": requestToken,
                        "oauth_request_secret": requestSecret]

      OAuthResult.fetch(with: LightningRouter.getAccessToken(platformType, parameters), onSuccess: { finalAuthRequest in
        onSuccess(finalAuthRequest)
      }, onError: { error in
        onError(error)
      })
    }
  }
}
