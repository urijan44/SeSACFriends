//
//  FirebaseErrorHandling.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/26.
//

import Foundation

final class FirebaseErrorHandling {
  class func PhoneAuthHandling(_ error: Error) -> String {
    let nsError = error as NSError
    switch nsError.code {
      case 17042:
        return ToastMessage.PhoneNumberAuthencication.MessageType.invalideType.rawValue
      case 17010:
        return ToastMessage.PhoneNumberAuthencication.MessageType.excessiveRequest.rawValue
      case 17000, 17002, 17043, 17044, 17045, 17046:
        return ToastMessage.VerificationCode.MessageType.invalideCode.rawValue
      default:
//        return "\(nsError.localizedDescription) \(nsError.code)"
        return ToastMessage.VerificationCode.MessageType.tokenError.rawValue
    }
  }
}
