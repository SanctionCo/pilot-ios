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
    
    static var authSession: SFAuthenticationSession? = nil
    
    static func authorizeService(platform: Platform, handler: @escaping (_ callBack: URL?, _ error: Error?) -> ()) {
        
        // Fetch the OAuth URL from thunder
        NetworkManager.sharedInstance.request(LightningRouter.getOauthURL(platform.type)).responseString() { response in
            
            debugPrint(response)
            switch response.result {
            case .success(let value):
                
                guard let authURL = URL(string: value) else {
                    return
                }
                
                let redirectUriString = authURL.getQueryParam(key: "redirect_uri")!
                
                OAuthManager.authSession = SFAuthenticationSession(url: authURL, callbackURLScheme: redirectUriString, completionHandler: handler)
                OAuthManager.authSession?.start()
                
            case .failure(let error):
                debugPrint(error)
            }
            
        }
        
    }
    
}
