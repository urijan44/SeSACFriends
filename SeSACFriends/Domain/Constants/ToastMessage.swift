//
//  ErrorMessages.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/25.
//

import Foundation

struct ToastMessage {
  struct PhoneNumberAuthencication {
    enum MessageType: String {
      case valideType = "전화 번호 인증 시작"
      case invalideType = "잘못된 전화번호 형식입니다."
      case excessiveRequest = "과도한 인증 시도가 있었습니다. 나중에 다시 시도해 주세요."
      case unknownError = "에러가 발생했습니다. 다시 시도해주세요"
      case none
    }

    var messageState: Bool = false
    var success: Bool = false
    var message: MessageType = .none
  }
}
