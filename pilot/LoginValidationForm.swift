//
//  LoginValidationForm.swift
//  pilot
//
//  Created by Nick Eckert on 12/12/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation

struct LoginValidationForm: ValidationForm {

  var email: String?
  var password: String?

  init(email: String?, password: String?) {
    self.email = email
    self.password = password
  }

  func validate() -> ValidationError? {
    var validationError: ValidationError? = nil

    if let emailValidationError = validateEmail(email: email) {
      validationError = emailValidationError
    }

    if let passwordValidationError = validatePassword(password: password) {
      validationError = passwordValidationError
    }

    return validationError
  }
}
