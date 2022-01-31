//
//  GenderViewModel.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/31.
//

import Foundation
import RxSwift
import RxRelay

final class GenderViewModel: CommonViewModel {
  let useCase: GenderUseCase
  let bag = DisposeBag()

  init(useCase: GenderUseCase) {
    self.useCase = useCase
  }

  struct Input {
    let genderInput: Observable<Int>
    let nextButton: Observable<Void>
  }

  struct Output {
    let nextButtonDisabled: BehaviorRelay<Bool> = .init(value: true)
    let present: PublishSubject<Void> = .init()
    let nicknameFailure: PublishSubject<Void> = .init()
  }

  func transform(_ input: Input) -> Output {
    let output = Output()

    input.nextButton.withLatestFrom(input.genderInput).subscribe(onNext: { [weak self] gender in
      self?.useCase.tryGender(gender: gender)
    }).disposed(by: bag)

    input.genderInput.subscribe(onNext: {
      output.nextButtonDisabled.accept($0 == -1)
    }).disposed(by: bag)

    useCase.success.subscribe(onNext: {
      output.present.onNext(())
    }).disposed(by: bag)

    useCase.nicknameFailure.subscribe(onNext: {
      output.nicknameFailure.onNext(())
    }).disposed(by: bag)

    return output
  }
}
