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
    let numberFormatPattern = text.count <= 12 ? 7 : 8
    for (index, char) in converted.enumerated() {
      if index == 3 && char != "-" {
        converted = converted.filter{ $0 != "-" }
        converted.insert("-", at: converted.index(converted.startIndex, offsetBy: 3))
      }
      if converted.count > 4
          && converted[converted.index(converted.startIndex, offsetBy: 3)] == "-"
          //123-567-9AB
          && index == numberFormatPattern
          && char != "-" {
        converted = converted.filter{ $0 != "-" }
        converted.insert("-", at: converted.index(converted.startIndex, offsetBy: 3))
        converted.insert("-", at: converted.index(converted.startIndex, offsetBy: numberFormatPattern))
      }
    }
    if converted.count > 13 {
      converted.removeLast()
    }
    return converted
  }

  func requestAuthCode() {
    var text = ""
    convertedPhoneNumber.subscribe(onNext: { phoneNumber in
      text = phoneNumber
    }).disposed(by: bag)

    let filtered = text.filter{ $0 != "-" }
    let phoneRegex = "^01[0-1, 7][0-9]{7,8}$"
    let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
    let state = phoneTest.evaluate(with: filtered)

    if state {
      //correct
    } else {
      //wrong
    }
  }
  //reqeust auth code //전화번호 검증하기, 결과에 따른 분기
  //phone number is wrong -> not URLRequest!
  //Request success -> View Transition //전화번호가 올바르면, 인증번호 뷰 전환
}
