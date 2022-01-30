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

    init(_ messageType: MessageType, messageState: Bool = true, success: Bool = false) {
      self.message = messageType
      self.messageState = messageState
      self.success = success
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

    init(_ messageType: MessageType, messageState: Bool = true, success: Bool = false) {
      self.message = messageType
    }
  }

  struct Nickname: DefaultToastMessage {
    enum MessageType: String {
      case invalidNickname = "닉네임은 1자 이상 10자 이내로 부탁드려요."
      case cantUseNickname = "해당 닉네임은 사용할 수 없습니다."
      case none
    }

    var messageState: Bool
    var success: Bool
    var message: MessageType

    init(_ messageType: MessageType = .none, messageState: Bool = true, success: Bool = false) {
      self.message = messageType
      self.messageState = messageState
      self.success = success
    }
  }

  struct Birthday: DefaultToastMessage {
    enum MessageType: String {
      case toYoung = "새싹친구는 만 17세 이상만 사용할 수 있습니다."
    }

    var messageState: Bool = true
    var success: Bool = false
    var message: MessageType = .toYoung
  }

  struct Email: DefaultToastMessage {
    enum MessageType: String {
      case invalidEmail = "이메일 형식이 올바르지 않습니다."
    }

    var messageState: Bool = true
    var success: Bool = false
    var message: MessageType = .invalidEmail
  }
}
