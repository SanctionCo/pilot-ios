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
  let authenticationReasonString = "Sign in to Pilot"

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
  /// Returns the type. Either none, TouchID, or FaceID
  func biometricType() -> BiometricType {
    switch context.biometryType {
    case .none:
      return .none
    case .touchID:
      return .touchID
    case .faceID:
      return .faceID
    }
  }

  /// Returns true if the device can use biometrics, false otherwise
  func canUseBiometrics() -> Bool {
    return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
  }

  /// Attempts to authenticate using biometrics
  /// If successfully authenticates, calls the onSuccess method on the main thread (DispatchQueue.main)
  /// If a failure occurs, calls onFailure method with the reason for failure in a String
  func authenticationWithBiometrics(onSuccess: @escaping () -> Void,
                                    onFailure: @escaping (FallbackType, String) -> Void) {
    context.localizedFallbackTitle = "Use Password"

    var authError: NSError?

    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
      context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                             localizedReason: authenticationReasonString) {success, evaluateError in
        if success {
          // Successful authentication
          onSuccess()
        } else {
          // User did not authenticate successfully
          guard let error = evaluateError else {
            onFailure(.fallbackWithError, "An unknown error occurred. Please login with your credentials.")
            return
          }

          let (fallbackType, reason) = self.evaluateAuthenticationError(errorCode: error._code)
          onFailure(fallbackType, reason)
        }
      }
    } else {
      // Authentication is either locked out or not available on device
      guard let error = authError else {
        onFailure(.fallbackWithError, "An unknown error occurred. Please login with your credentials.")
        return
      }

      let (fallbackType, reason) = self.evaluateAuthenticationPolicyError(errorCode: error.code)
      onFailure(fallbackType, reason)
    }
  }

  /// Determines the authentication error. Use this method when checking error
  /// after user has attempted to authenticate
  private func evaluateAuthenticationError(errorCode: Int) -> (FallbackType, String) {
    switch errorCode {
    case LAError.authenticationFailed.rawValue:
      return (.fallbackWithError, "Too many incorrect attempts. Please use your password.")

    case LAError.appCancel.rawValue:
      return (.fallbackWithoutError, "Authentication was cancelled by application")

    case LAError.invalidContext.rawValue:
      return (.fallbackWithoutError, "The context is invalid")

    case LAError.notInteractive.rawValue:
      return (.fallbackWithoutError, "Not interactive")

    case LAError.passcodeNotSet.rawValue:
      return (.fallbackWithoutError, "Passcode is not set on the device")

    case LAError.systemCancel.rawValue:
      return (.fallbackWithoutError, "Authentication was cancelled by the system")

    case LAError.userCancel.rawValue:
      return (.fallbackWithoutError, "The user did cancel")

    case LAError.userFallback.rawValue:
      return (.fallbackWithoutError, "The user chose to use the fallback")

    default:
      return (.fallbackWithError, "An unknown error occurred. Please login with your credentials.")
    }
  }

  /// Determines the authentication policy error. Use this method when checking error
  /// given before authentication could even take place
  private func evaluateAuthenticationPolicyError(errorCode: Int) -> (FallbackType, String) {
    switch errorCode {
    case LAError.biometryNotAvailable.rawValue:
      return (.fallbackWithoutError,
              "Authentication could not start because the device does not support biometric authentication.")

    case LAError.biometryLockout.rawValue:
      return (.fallbackWithoutError,
              "The user has been locked out of biometric authentication, due to failing authentication too many times.")

    case LAError.biometryNotEnrolled.rawValue:
      return (.fallbackWithoutError,
              "Authentication could not start because the user has not enrolled in biometric authentication.")

    // Fall back to other method to continue checking error code
    default:
      return evaluateAuthenticationError(errorCode: errorCode)
    }
  }

  /// Check if the given email and password are different from the ones stored in keychain
  /// If different, this returns true. If they are the same, this returns false.
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

enum FallbackType: String {
  case fallbackWithError
  case fallbackWithoutError
}
