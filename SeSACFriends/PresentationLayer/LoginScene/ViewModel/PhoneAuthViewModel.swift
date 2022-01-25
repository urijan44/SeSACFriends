//
//  PhoneAuthViewModel.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/21.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

final class PhoneAuthViewModel {

  enum AuthenticationPhase {
    case inputPhoneNumber
    case inputValidateNumber
  }

  let coordinator: Coordinator
  let useCase: PhoneAuthUseCase
  var bag = DisposeBag()

  init(coordinator: Coordinator, useCase: PhoneAuthUseCase) {
    self.coordinator = coordinator
    self.useCase = useCase
  }

  struct Input {
    let textInput: Observable<String>
    let button: Observable<Void>
  }

  struct Output {
    let placeholder: BehaviorRelay<String> = .init(value: "")
    let buttonText: BehaviorRelay<String> = .init(value: "")
    let titleText: BehaviorRelay<String> = .init(value: "")
    let convertPhoneNumberText: BehaviorRelay<String> = .init(value: "")
    let phoneNumberValidateState: BehaviorRelay<Bool> = .init(value: false)
    let showToast = PublishRelay<ToastMessage.PhoneNumberAuthencication>()
    let buttonEnable: BehaviorRelay<Bool> = .init(value: true)
  }

  func transform(_ input: Input) -> Output {
    input.textInput.subscribe(onNext: { [weak self] phoneNumber in
      self?.useCase.validatePhoneNumber(phoneNumber)
      self?.useCase.convertPhoneNumber(phoneNumber)
    }).disposed(by: bag)

    input.button.subscribe(onNext: { [weak self] _ in
      self?.useCase.requestAuthCode()
    }).disposed(by: bag)

    let output = Output()
    output.placeholder.accept("휴대폰 번호(-없이 숫자만 입력)")
    output.buttonText.accept("인증 문자 받기")
    output.titleText.accept("새싹 서비스 이용을 위해\n휴대폰 번호를 입력해주세요")

    useCase.phoneNumberValidateState.subscribe(onNext: { state in
      output.phoneNumberValidateState.accept(state)
    }).disposed(by: bag)

    useCase.convertedPhoneNumber.subscribe(onNext: { converted in
      output.convertPhoneNumberText.accept(converted)
    }).disposed(by: bag)

    useCase.phoneAuthToastMessage.subscribe(onNext: { message in
      output.showToast.accept(message)
    }).disposed(by: bag)

    useCase.buttonEnable.subscribe(onNext: { state in
      output.buttonEnable.accept(state)
    }).disposed(by: bag
    )
    return output
  }
}
