//
//  ValidationError.swift
//  pilot
//
//  Created by Nick Eckert on 12/12/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation

struct ValidationError {

  var errorCode: Int!
  var errorString: String!

  init(code: Int, message: String) {
    self.errorCode = code
    self.errorString = message
  }

  struct ErrorCode {
    static let errorCodeEmptyText = 0
    static let errorInvalidEmail = 1
    static let errorInvalidPassword = 2
    static let errorCodeinvalidMobilNumber = 3
    static let errorCodeMaxLengthExceeded = 4
    static let errorCodeMissMatchPasswords = 5
  }

  struct ErrorMessage {
    static let messageEmptyEmail = "Email field cannot be empty"
    static let messageEmptyPassword = "Password field cannot be empty"
    static let messageInvalidEmail = "Email is invalid"
    static let messageInvalidPassword = "Password is invalid"
    static let messageMaxLengthExceeded = "Maximum length has been exceeded"
    static let messageInvalidMobileNumber = "Invalid mobile number"
    static let messageMissMatchPasswords = "The provided passwords do not match"
  }
}
