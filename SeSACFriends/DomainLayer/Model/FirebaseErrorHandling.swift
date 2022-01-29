//
//  FirebaseErrorHandling.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/26.
//

import Foundation
import FirebaseAuth

final class FirebaseErrorHandling {
  class func PhoneAuthHandling(_ error: Error) -> Int {
    let nsError = error as NSError
    return nsError.code
  }

  class func PhoneAuthHandling2(_ error: Error) -> ToastMessage.PhoneNumberAuthencication.MessageType {
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
}
