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
  let showToast: PublishSubject<ToastMessage.Nickname> = .init()

  func tryGender(gender: Int) {
    userSession.saveGender(gender: gender)
    signUpRequest()
  }

  private func signUpRequest() {
    let api = SeSACRemoteAPI()
    api.signUp(idToken: userSession.loadIdToken() ?? "") { [weak self] result in
      switch result {
        case .success:
          self?.success.onNext(())
        case .failure(let error):
          switch error {
            case .cannotUseNickname:
              self?.nicknameFailure.onNext(())
            default:
              self?.showToast.onNext(.init(.none, messageState: true, success: false))
          }
      }
    }

  }
}
