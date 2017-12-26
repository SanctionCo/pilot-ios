//
//  ValidationForm.swift
//  pilot
//
//  Created by Nick Eckert on 12/12/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation

// Implement this protocol to create forms for validating user input
protocol ValidationForm {
  func validate() -> ValidationError?
}

extension ValidationForm {

  func validateEmail(email: String?) -> ValidationError? {
    guard let email = email else {
      return ValidationError(code: ValidationError.ErrorCode.errorInvalidEmail,
                             message: ValidationError.ErrorMessage.messageInvalidEmail)
    }

    var validationError: ValidationError? = nil

    if email.isEmpty {
      validationError = ValidationError(code: ValidationError.ErrorCode.errorCodeEmptyText,
                                        message: ValidationError.ErrorMessage.messageEmptyEmail)
    } else {
      let regexEmail: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
      let predicate = NSPredicate(format: "SELF MATCHES %@", regexEmail)
      let result = predicate.evaluate(with: email)
      if !result {
        validationError = ValidationError(code: ValidationError.ErrorCode.errorInvalidEmail,
                                          message: ValidationError.ErrorMessage.messageInvalidEmail)
      }
    }

    return validationError
  }

  func validatePassword(password: String?) -> ValidationError? {
    guard let password = password else {
      return ValidationError(code: ValidationError.ErrorCode.errorInvalidPassword,
                             message: ValidationError.ErrorMessage.messageInvalidPassword)
    }

    var validationError: ValidationError? = nil

    if password.isEmpty {
      validationError = ValidationError(code: ValidationError.ErrorCode.errorInvalidPassword,
                                        message: ValidationError.ErrorMessage.messageEmptyPassword)
    }

    return validationError
  }

  func validateEqualPasswords(passwordOne: String?, passwordTwo: String?) -> ValidationError? {
    guard let passwordOne = passwordOne else {
      return ValidationError(code: ValidationError.ErrorCode.errorInvalidPassword,
                             message: ValidationError.ErrorMessage.messageInvalidPassword)
    }

    guard let passwordTwo = passwordTwo else {
      return ValidationError(code: ValidationError.ErrorCode.errorInvalidPassword,
                             message: ValidationError.ErrorMessage.messageInvalidPassword)
    }

    var validationError: ValidationError? = nil

    if passwordOne != passwordTwo {
      validationError = ValidationError(code: ValidationError.ErrorCode.errorCodeMissMatchPasswords,
                                        message: ValidationError.ErrorMessage.messageMissMatchPasswords)
    }

    return validationError
  }
}
