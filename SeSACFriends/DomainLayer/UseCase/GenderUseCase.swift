//
//  GenderUseCase.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/31.
//

import Foundation
import RxSwift

final class GenderUseCase: UserSessionUseCase {
  let success: PublishSubject<Void> = .init()
  let nicknameFailure: PublishSubject<Void> = .init()

  func tryGender(gender: Int) {
    userSession.saveGender(gender: gender)
    signUpRequest()
  }

  private func signUpRequest() {
    success.onNext(())
//    nicknameFailure.onNext(())
  }
}
