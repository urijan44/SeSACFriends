//
//  PhoneAuthUseCase.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/24.
//

import Foundation
import RxSwift

final class PhoneAuthUseCase {
  let bag = DisposeBag()
  var phoneNumberValidateState = BehaviorSubject<Bool>(value: false)
  var convertedPhoneNumber = BehaviorSubject<String>(value: "")

  func validatePhoneNumber(_ text: String) {
    let phoneRegex = "^01[0-1, 7][0-9]{7,8}$"
    let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)

    let state =
    !phoneTest.evaluate(with:text)
    && !(text.count >= 10)

    phoneNumberValidateState.onNext(state)
  }

  func convertPhoneNumber(_ text: String) {

    let converted = phoneNumberFormat(text)
    convertedPhoneNumber.onNext(converted)
  }

  private func phoneNumberFormat(_ text: String) -> String {

    var converted = text

    for (index, char) in converted.enumerated() {
      if index == 3 && char != "-" {
        converted = converted.filter{ $0 != "-" }
        converted.insert("-", at: converted.index(converted.startIndex, offsetBy: 3))
      }

      if converted.count > 4
          && converted[converted.index(converted.startIndex, offsetBy: 3)] == "-"
          && index == 8
          && char != "-" {
        converted = converted.filter{ $0 != "-" }
        converted.insert("-", at: converted.index(converted.startIndex, offsetBy: 3))
        converted.insert("-", at: converted.index(converted.startIndex, offsetBy: 8))
      }
    }
    return converted

  }
}
