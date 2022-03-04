//
//  ValidateCodeUseCase.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/27.
//

import Foundation
import RxSwift
import RxRelay
import FirebaseAuth

final class ValidateCodeUseCase: UseCase {
  private let initializeTime = 60
  private var timer = Timer()

  var timeOut: BehaviorRelay<String> = .init(value: "01:00")
  var tryButtonDisabled: BehaviorRelay<Bool> = .init(value: true)
  var tryButtonEnabled: BehaviorRelay<Bool> = .init(value: true)
  var retryButtonDisabled: BehaviorRelay<Bool> = .init(value: true)
  var verificationToastMessage: PublishSubject<ToastMessage.VerificationCode> = .init()
  var present: PublishSubject<Void> = .init()
  var login: PublishSubject<Void> = .init()
  var inProgress: BehaviorRelay<Bool> = .init(value: false)

  private lazy var time: Int = initializeTime

  func sendCodeShowToast() {
    let message = ToastMessage.VerificationCode(.loadView, success: true)
    verificationToastMessage.onNext(message)
  }

  func timeOutCalculate() {
    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(sendTimeOut), userInfo: nil, repeats: true)
  }

  func codeInputCheck(_ text: String) {
    tryButtonDisabled.accept(!(text.count == 6))
  }

  @objc private func sendTimeOut() {
    if time <= 1 {
      timer.invalidate()
      retryButtonDisabled.accept(false)
    }
    time -= 1

    timeOut.accept(timeConvert())
  }

  private func timeConvert() -> String {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.minute, .second]
    formatter.unitsStyle = .full
    let string = formatter.string(from: TimeInterval(time)) ?? ""
    return string
  }

  func retryReqeust() {
    time = initializeTime
    timeOut.accept(timeConvert())
    timeOutCalculate()
    retryButtonDisabled.accept(true)
  }

  func codeVerify(_ receivedVerifyCode: String?) {
    tryButtonEnabled.accept(false)
    inProgress.accept(true)
    let preVerifyCode = UserSession.loadPreReceiveVerifId() ?? ""

    let credential = PhoneAuthProvider.provider().credential(withVerificationID: preVerifyCode, verificationCode: receivedVerifyCode ?? "")
    Auth.auth().signIn(with: credential) { [weak self] success, error in
      if let error = error {
        let message = ToastMessage.VerificationCode(FirebaseErrorHandling.VerificationCode(error))
        self?.verificationToastMessage.onNext(message)
      } else {
        //firebase register success
        //save idToken
        Auth.auth().currentUser?.getIDTokenForcingRefresh(true, completion: { idToken, error in
          if let error = error, let code = AuthErrorCode(rawValue: (error as NSError).code)  {
            print("showerrortoast\(code)")
            return
          }

          if let idToken = idToken {
            UserSession.shared.saveIdToken(idToken: idToken)
            self?.timer.invalidate()

            let api = SeSACRemoteAPI()
            api.signIn(idToken: idToken) { result in
              switch result {
                case .success:
                  self?.login.onNext(())
                case .failure:
                  self?.present.onNext(())
              }
            }
            return
          }
        })
      }
      self?.inProgress.accept(false)
      self?.tryButtonEnabled.accept(true)
    }
  }
}
