//
//  ValidateNumberCheckViewModel.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/25.
//

import Foundation
import RxSwift
import RxRelay

final class ValidateCodeCheckViewModel: CommonViewModel {

  let useCase: ValidateCodeUseCase
  let bag = DisposeBag()

  init(useCase: ValidateCodeUseCase) {
    self.useCase = useCase
  }

  struct Input {
    //view appear -> time running!
    let viewAppear: Observable<Void>
    let codeInput: Observable<String>
    let retryButton: Observable<Void>
    let tryAuthentication: Observable<Void>
    let popViewButton: Observable<Void>
  }

  struct Output {
    let tryButtonEnable: BehaviorRelay<Bool> = .init(value: false)
    let tryButtonBlock: BehaviorRelay<Bool> = .init(value: true)
    let retryButtonEnable: BehaviorRelay<Bool> = .init(value: false)
    let timer: BehaviorRelay<String> = .init(value: "01:00")
    let showToast: PublishRelay<ToastMessage.VerificationCode> = .init()
    let present: PublishSubject<Void> = .init()
    let login: PublishSubject<Void> = .init()
    let inPprogress: BehaviorRelay<Bool> = .init(value: false)
  }

  func transform(_ input: Input) -> Output {

    input.codeInput.subscribe(onNext: { [weak self] code in
      self?.useCase.codeInputCheck(code)
    }).disposed(by: bag)

    input.viewAppear
      .subscribe(onNext: { [weak self] _ in
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
          self?.useCase.timeOutCalculate()
          self?.useCase.sendCodeShowToast()
        }
    }).disposed(by: bag)

    input.retryButton.subscribe(onNext: { [weak self] _ in
      self?.useCase.retryReqeust()
    }).disposed(by: bag)

//    Observable.combineLatest(input.tryAuthentication, input.codeInput)
//      .subscribe(onNext: { [weak self] tap, code in
//        self?.useCase.codeVerify(code)
//    }).disposed(by: bag)

    let output = Output()

    input.tryAuthentication.withLatestFrom(input.codeInput)
      .subscribe(onNext: { [weak self] code in
        self?.useCase.codeVerify(code)
      }).disposed(by: bag)

    useCase.inProgress.subscribe(onNext: {
      output.inPprogress.accept($0)
    }).disposed(by: bag)

    useCase.timeOut.subscribe(onNext: {
      output.timer.accept($0)
    }).disposed(by: bag)

    useCase.tryButtonDisabled.subscribe(onNext: {
      output.tryButtonEnable.accept($0)
    }).disposed(by: bag)

    useCase.retryButtonDisabled.subscribe(onNext: {
      output.retryButtonEnable.accept($0)
    }).disposed(by: bag)

    useCase.tryButtonEnabled.subscribe(onNext: {
      output.tryButtonBlock.accept($0)
    }).disposed(by: bag)

    useCase.login.subscribe(onNext: {
      output.login.onNext(())
    }).disposed(by: bag)

    useCase.verificationToastMessage.subscribe(onNext: { message in
      if message.messageState {
        output.showToast.accept(message)
      }
    }).disposed(by: bag)

    useCase.present.subscribe(onNext: { _ in
      output.present.onNext(())
    }).disposed(by: bag)

    return output
  }
}
