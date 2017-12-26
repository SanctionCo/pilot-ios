//
//  RegisterValidationForm.swift
//  pilot
//
//  Created by Nick Eckert on 12/13/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation

struct RegisterValidationForm: ValidationForm {
  var email: String?
  var password: String?
  var confirmPassword: String?

  init(email: String?, password: String?, confirmPassword: String?) {
    self.email = email
    self.password = password
    self.confirmPassword = confirmPassword
  }

  func validate() -> ValidationError? {
    var validationError: ValidationError? = nil

    if let emailValidationError = validateEmail(email: email) {
      validationError = emailValidationError
    }

    if let passwordValidationError = validatePassword(password: password) {
      validationError = passwordValidationError
    }

    if let confirmPasswordValidationError = validatePassword(password: confirmPassword) {
      validationError = confirmPasswordValidationError
    }

    if let passwordMissMatchValidationError = validateEqualPasswords(passwordOne: password,
                                                                     passwordTwo: confirmPassword) {
      validationError = passwordMissMatchValidationError
    }

    return validationError
  }
}
