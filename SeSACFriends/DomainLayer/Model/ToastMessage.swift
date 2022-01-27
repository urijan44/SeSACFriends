//
//  ErrorMessages.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/25.
//

import Foundation

protocol DefaultToastMessage {
  associatedtype MessageType: RawRepresentable
  var messageState: Bool { get set }
  var success: Bool { get set }
  var message: MessageType { get set }
  var sendingMessage: String { get }
  mutating func errorCodeConvert(_ code: Int)
}

extension DefaultToastMessage {
  var sendingMessage: MessageType.RawValue {
    return self.message.rawValue
  }
}

struct ToastMessage {
  struct PhoneNumberAuthencication: DefaultToastMessage {
    enum MessageType: String {
      case valideType = "전화 번호 인증 시작"
      case invalideType = "잘못된 전화번호 형식입니다."
      case excessiveRequest = "과도한 인증 시도가 있었습니다. 나중에 다시 시도해 주세요."
      case unknownError = "에러가 발생했습니다. 다시 시도해주세요"
      case none
    }

    var messageState: Bool = true
    var success: Bool = false
    var message: MessageType = .none

    mutating func errorCodeConvert(_ code: Int) {
      switch code {
        case 17042:
          message = .invalideType
        case 17010:
          message = .excessiveRequest
        default:
          message = .unknownError
      }
    }
  }

  struct VerificationCode: DefaultToastMessage {
    enum MessageType: String {
      case loadView = "인증번호를 보냈습니다."
      case timeOut, invalideCode = "전화 번호 인증 실패"
      case none, tokenError = "에러가 발생했습니다. 잠시 후 다시 시도해주세요."

    }

    var messageState: Bool = true

    var success: Bool = false

    var message: MessageType = .none

    mutating func errorCodeConvert(_ code: Int) {
      switch code {
        case 17051:
          message = .timeOut
        case 17044, 17045, 17046:
          message = .invalideCode
        default:
          message = .tokenError
      }
    }
  }
}
