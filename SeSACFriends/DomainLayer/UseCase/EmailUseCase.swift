//
//  EmailUseCase.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/31.
//

import Foundation
import RxSwift

final class EmailUseCase: UserSessionUseCase {
  let bag = DisposeBag()
  let isValidEmail: BehaviorSubject<Bool> = .init(value: false)
  let showToastMessage: PublishSubject<ToastMessage.Email> = .init()
  let success: PublishSubject<Void> = .init()

  func emailValidation(email string: String) {
    isValidEmail.onNext(isValidEmail(email: string))
  }

  private func isValidEmail(email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: email)
  }

  func tryInputEmail(email string: String) {
    var state = false
    isValidEmail.subscribe(onNext: {
      state = $0
    }).disposed(by: bag)

    if state {
      userSession.saveEmail(email: string)
      success.onNext(())
    } else {
      showToastMessage.onNext(ToastMessage.Email.init())
    }
  }
}
