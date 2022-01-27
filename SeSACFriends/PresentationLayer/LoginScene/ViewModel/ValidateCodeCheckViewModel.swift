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
    let retryButtonEnable: BehaviorRelay<Bool> = .init(value: false)
    let timer: BehaviorRelay<String> = .init(value: "01:00")
  }

  func transform(_ input: Input) -> Output {

    input.codeInput.subscribe(onNext: { [weak self] code in
      self?.useCase.codeInputCheck(code)
    }).disposed(by: bag)

    input.viewAppear.subscribe(onNext: { [weak self] _ in
      self?.useCase.timeOutCalculate()
    }).disposed(by: bag)

    input.retryButton.subscribe(onNext: { [weak self] _ in
      self?.useCase.retryReqeust()
    }).disposed(by: bag)

    input.popViewButton.subscribe(onNext: {
      print("dismiss tap!!")
    }).disposed(by: bag)

    let output = Output()

    useCase.timeOut.subscribe(onNext: {
      output.timer.accept($0)
    }).disposed(by: bag)

    useCase.tryButtonDisabled.subscribe(onNext: {
      output.tryButtonEnable.accept($0)
    }).disposed(by: bag)

    useCase.retryButtonDisabled.subscribe(onNext: {
      output.retryButtonEnable.accept($0)
    }).disposed(by: bag)

    return output
  }
}
