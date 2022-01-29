//
//  FirebaseErrorHandling.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/26.
//

import Foundation
import FirebaseAuth

final class FirebaseErrorHandling {

  class func PhoneAuthHandling(_ error: Error) -> ToastMessage.PhoneNumberAuthencication.MessageType {
    guard let error = AuthErrorCode(rawValue: (error as NSError).code) else { return .unknownError}
    switch error {
      case .invalidPhoneNumber:
        return .invalideType
      case .tooManyRequests:
        return .excessiveRequest
      default:
        return .unknownError
    }
  }

  class func VerificationCode(_ error: Error) -> ToastMessage.VerificationCode.MessageType {
    guard let error = AuthErrorCode(rawValue: (error as NSError).code) else { return .none }
    switch error {
      case .sessionExpired:
        return .timeOut
      case .missingVerificationID,
          .missingVerificationCode,
          .invalidVerificationID,
          .invalidVerificationCode:
        return .invalideCode
      default:
        return .tokenError
    }
  }
}
