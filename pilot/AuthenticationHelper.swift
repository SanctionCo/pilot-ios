//
//  KeychainHelper.swift
//  pilot
//
//  Created by Rohan Nagar on 1/14/18.
//  Copyright © 2018 sanction. All rights reserved.
//

import Foundation
import LocalAuthentication
import Locksmith

struct AuthenticationHelper {
  let context = LAContext()

  /// Saves the given email and password to keychain for the account "Pilot".
  func saveToKeychain(email: String, password: String) {
    if isNewValue(email: email, password: password) {
      do {
        try Locksmith.updateData(data: ["email": email, "password": password],
                                 forUserAccount: "Pilot")
        print("Saved")
      } catch {
        print("Unable to save data to keychain")
      }
    }
  }

  /// Gets the saved email and password from keychain.
  /// Returns (email, password) as a tuple.
  func getFromKeychain() -> (String, String)? {
    if let dictionary = Locksmith.loadDataForUserAccount(userAccount: "Pilot"),
       let email = dictionary["email"] as? String,
       let password = dictionary["password"] as? String {
      return (email, password)
    }

    return nil
  }

  /// Determines which biometric type is available on the device.
  /// Returns the type: either none, TouchID, or FaceID
  func biometricType() -> BiometricType {
    _ = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
    switch context.biometryType {
    case .none:
      return .none
    case .touchID:
      return .touchID
    case .faceID:
      return .faceID
    }
  }

  func authenticationWithTouchID(onSuccess: @escaping () -> Void, onFailure: @escaping (String) -> Void) {
    context.localizedFallbackTitle = "Use Password"

    var authError: NSError?
    let reasonString = "Sign in to Pilot"

    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
      context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                             localizedReason: reasonString) {success, evaluateError in
        if success {
          DispatchQueue.main.async {
            onSuccess()
          }
        } else {
          //TODO: User did not authenticate successfully, look at error and take appropriate action
          guard let error = evaluateError else {
            onFailure("An unknown error occurred. Please login with your credentials.")
            return
          }

          let reason = self.evaluateAuthenticationPolicyMessageForLA(errorCode: error._code)

          //TODO: If you have choosen the 'Fallback authentication mechanism selected' (LAError.userFallback). Handle gracefully
          print(reason)
          onFailure(reason)
        }
      }
    } else {
      guard let error = authError else {
        onFailure("An unknown error occurred. Please login with your credentials.")
        return
      }

      //TODO: Show appropriate alert if biometry/TouchID/FaceID is lockout or not enrolled
      let reason = self.evaluateAuthenticationPolicyMessageForLA(errorCode: error.code)

      print(reason)
      onFailure(reason)
    }
  }

  private func evaluatePolicyFailErrorMessageForLA(errorCode: Int) -> String {
    switch errorCode {
    case LAError.biometryNotAvailable.rawValue:
      return "Authentication could not start because the device does not support biometric authentication."

    case LAError.biometryLockout.rawValue:
      return "The user has been locked out of biometric authentication, due to failing authentication too many times."

    case LAError.biometryNotEnrolled.rawValue:
      return "Authentication could not start because the user has not enrolled in biometric authentication."

    default:
      return "Did not find error code on LAError object"
    }
  }

  private func evaluateAuthenticationPolicyMessageForLA(errorCode: Int) -> String {
    switch errorCode {
    case LAError.authenticationFailed.rawValue:
      return "The user failed to provide valid credentials"

    case LAError.appCancel.rawValue:
      return "Authentication was cancelled by application"

    case LAError.invalidContext.rawValue:
      return "The context is invalid"

    case LAError.notInteractive.rawValue:
      return "Not interactive"

    case LAError.passcodeNotSet.rawValue:
      return "Passcode is not set on the device"

    case LAError.systemCancel.rawValue:
      return "Authentication was cancelled by the system"

    case LAError.userCancel.rawValue:
      return "The user did cancel"

    case LAError.userFallback.rawValue:
      return "The user chose to use the fallback"

    default:
      return evaluatePolicyFailErrorMessageForLA(errorCode: errorCode)
    }
  }

  private func isNewValue(email: String, password: String) -> Bool {
    if let result = getFromKeychain() {
      let existingEmail = result.0
      let existingPassword = result.1

      return existingEmail == email && existingPassword == password ? false : true
    }

    return true
  }
}

enum BiometricType: String {
  case none
  case touchID = "TouchID"
  case faceID = "FaceID"
}
