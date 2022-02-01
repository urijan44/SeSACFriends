//
//  BirthdayUseCase.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/31.
//

import Foundation
import RxSwift

final class BirthdayUseCase: UserSessionUseCase {
  let bag = DisposeBag()

  let birthdayValidateState: BehaviorSubject<Bool> = .init(value: false)
  let showToastMessage: PublishSubject<ToastMessage.Birthday> = .init()
  let success: PublishSubject<Void> = .init()

  func birthdayValidation(birthday: Date) {
    let calendar = Calendar(identifier: .gregorian)
    guard let age = calendar.dateComponents([.year], from: birthday, to: Date()).year else { return }

    birthdayValidateState.onNext(age >= 17)
  }

  func tryInputBirthday(_ date: Date) {
    var state = false

    birthdayValidateState.subscribe(onNext: {
      state = $0
    }).disposed(by: bag)

    if state {
      userSession.saveBirthDay(birthday: date)
      success.onNext(())
    } else {
      showToastMessage.onNext(ToastMessage.Birthday.init())
    }
  }

  func initBirthday() -> Maybe<Date> {
    let birthday = UserSession.shared.loadBirthDay()
    return Maybe<Date>.create { maybe in
      guard let birthday = birthday else {
        maybe(.completed)
        return Disposables.create()
      }
      maybe(.success(birthday))
      return Disposables.create()
    }
  }
}
