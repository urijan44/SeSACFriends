//
//  EmailViewModel.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/31.
//

import RxSwift
import RxRelay
import UIKit

final class EmailViewModel: CommonViewModel {

  let useCase: EmailUseCase
  let bag = DisposeBag()

  init(useCase: EmailUseCase) {
    self.useCase = useCase
  }

  struct Input {
    let view: UIView
    let viewTap: Observable<UITapGestureRecognizer>
    let keyboardSize: Observable<CGRect>
    let viewAppear: Observable<Void>
    let emailInput: Observable<String>
    let nextButton: Observable<Void>
  }

  struct Output {
    let nextButtonDisabled: BehaviorRelay<Bool> = .init(value: true)
    let showToast: PublishRelay<ToastMessage.Email> = .init()
    let hideKeyboard: PublishRelay<Void> = .init()
    let present: PublishSubject<Void> = .init()
  }

  func transform(_ input: Input) -> Output {
    let output = Output()
    var keyboardSize: CGFloat = 0
    input.keyboardSize.map { size in
      size.height
    }.subscribe(onNext: { height in
      keyboardSize = height
    }).disposed(by: bag)

    input.viewTap.subscribe(onNext: { gesture in
      if gesture.location(in: input.view).y < input.view.bounds.maxY - keyboardSize {
        output.hideKeyboard.accept(())
      }
    }).disposed(by: bag)

    input.emailInput.subscribe(onNext: { [weak self] email in
      self?.useCase.emailValidation(email: email)
    }).disposed(by: bag)

    input.nextButton.withLatestFrom(input.emailInput).subscribe(onNext: { [weak self] email in
      self?.useCase.tryInputEmail(email: email)
    }).disposed(by: bag)

    useCase.showToastMessage.subscribe(onNext: {
      output.showToast.accept($0)
    }).disposed(by: bag)

    useCase.success.subscribe(onNext: {
      output.present.onNext(())
    }).disposed(by: bag)

    useCase.isValidEmail.subscribe(onNext: {
      output.nextButtonDisabled.accept(!$0)
    }).disposed(by: bag)

    return output
  }
}
