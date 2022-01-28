//
//  SignUpUseCase.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/28.
//

import Foundation
import RxSwift

final class SignUpUseCase: UseCase {

  let userSession = UserSession.shared
  let bag = DisposeBag()

  let nicknameValidateState: BehaviorSubject<Bool> = .init(value: false)
  let showToastMessage: PublishSubject<ToastMessage.Nickname> = .init()
  let success: PublishSubject<Void> = .init()

  func nicknameValidation(nickname: String) {
    nicknameValidateState.onNext(
      nickname.count > 0 && nickname.count <= 10
    )
  }

  func tryNickname(nickname: String) {
    var state = false

    nicknameValidateState.subscribe(onNext: {
      state = $0
    }).disposed(by: bag)

    if state {
      userSession.saveNickname(nickname: nickname)
//      success.onNext(())
    } else {
      var message = ToastMessage.Nickname.init()
      message.message = .invalidNickname
      showToastMessage.onNext(message)
    }
  }

}
