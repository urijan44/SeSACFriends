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
  var phase: BehaviorRelay<AuthenticationPhase> = BehaviorRelay(value: .inputPhoneNumber)
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
  }

  func transform(_ input: Input) -> Output {
    input.textInput.subscribe(onNext: { [weak self] phoneNumber in
      self?.useCase.validatePhoneNumber(phoneNumber)
      self?.useCase.convertPhoneNumber(phoneNumber)
    }).disposed(by: bag)

    input.button.subscribe(onNext: { _ in
      self.phase.accept(.inputValidateNumber)
    }).disposed(by: bag)

    let output = Output()

    phase.subscribe(onNext: {
      if $0 == .inputPhoneNumber {
        output.placeholder.accept("휴대폰 번호(-없이 숫자만 입력)")
        output.buttonText.accept("인증 문자 받기")
        output.titleText.accept("새싹 서비스 이용을 위해\n휴대폰 번호를 입력해주세요")
      } else {
        output.placeholder.accept("인증번호 입력")
        output.buttonText.accept("인증하고 시작하기")
        output.titleText.accept("인증번호가 문자로 전송되었어요")
      }
    })
      .disposed(by: bag)

    useCase.phoneNumberValidateState.subscribe(onNext: { state in
      output.phoneNumberValidateState.accept(state)
    }).disposed(by: bag)

    useCase.convertedPhoneNumber.subscribe(onNext: { converted in
      output.convertPhoneNumberText.accept(converted)
    }).disposed(by: bag)
    return output
  }
}
