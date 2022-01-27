//
//  NicknameViewModel.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/28.
//

import Foundation
import RxSwift
import RxRelay

final class NicknameViewModel: CommonViewModel {

  var useCase: SignUpUseCase
  let bag = DisposeBag()

  init(useCase: SignUpUseCase) {
    self.useCase = useCase
  }

  struct Input {
    let nickNameInput: Observable<String>
    let nextButton: Observable<Void>
  }

  struct Output {
    let nextButtonDisabled: BehaviorRelay<Bool> = .init(value: false)
    let showToast: PublishRelay<ToastMessage.Nickname> = .init()
    let present: PublishSubject<Bool> = .init()
  }
  
  func transform(_ input: Input) -> Output {

    input.nickNameInput.subscribe(onNext: { [weak self] text in
        self?.useCase.nicknameValidation(nickname: text)
    }).disposed(by: bag)

    input.nextButton.withLatestFrom(input.nickNameInput)
      .subscribe(onNext: { [weak self] nickname in
      self?.useCase.tryNickname(nickname: nickname)
    }).disposed(by: bag)

    let output = Output()

    useCase.nicknameValidateState.subscribe(onNext: { state in
      output.nextButtonDisabled.accept(!state)
    }).disposed(by: bag)

    useCase.showToastMessage.subscribe(onNext: { message in
      output.showToast.accept(message)
    }).disposed(by: bag)

    useCase.success.subscribe(onNext: { _ in
      output.present.onNext(true)
    }).disposed(by: bag)

    return output
  }
}
