//
//  BithdayViewModel.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/30.
//

import Foundation
import RxSwift
import RxRelay
import UIKit

final class BirthdayViewModel: CommonViewModel {

  let datePickerSize = UIScreen.main.bounds.height * 0.266
  private let useCase: BirthdayUseCase

  let bag = DisposeBag()

  init(useCase: BirthdayUseCase) {
    self.useCase = useCase
  }

  struct Input {
    let view: UIView
    let viewAppear: Observable<Void>
    let viewTap: Observable<UITapGestureRecognizer>
    let tapTextField: Observable<UITapGestureRecognizer>
    let dateInput: Observable<Date>
    let nextButton: Observable<Void>
  }

  struct Output {
    let nextButtonDisabled: BehaviorRelay<Bool> = .init(value: false)
    let showToast: PublishRelay<ToastMessage.Birthday> = .init()
    let showDatePicker: PublishSubject<Void> = .init()
    let hideDatePicker: PublishSubject<Void> = .init()
    let selectedDate: BehaviorRelay<Date> = .init(value: Date())
    let birthFieldActiveState: BehaviorRelay<Bool> = .init(value: false)
    let present: PublishSubject<Void> = .init()
  }

  func transform(_ input: Input) -> Output {
    let output = Output()

    input.viewAppear.subscribe(onNext: { _ in
//      output.nextButtonDisabled.accept(true)
    }).disposed(by: bag)

    input.viewTap.subscribe(onNext: { [weak self] gesture in
      guard let self = self else { return }
      if gesture.location(in: input.view).y < input.view.bounds.maxY - self.datePickerSize {
        output.birthFieldActiveState.accept(false)
        output.hideDatePicker.onNext(())
      }
    }).disposed(by: bag)

    input.tapTextField.subscribe(onNext: { _ in
      output.showDatePicker.onNext(())
      output.birthFieldActiveState.accept(true)
    }).disposed(by: bag)

    input.dateInput.subscribe(onNext: { [weak self] date in
      output.selectedDate.accept(date)
      self?.useCase.birthdayValidation(birthday: date)
    }).disposed(by: bag)

    input.nextButton.withLatestFrom(input.dateInput)
      .subscribe(onNext: { [weak self] date in
        self?.useCase.tryInputBirthday(date)
    }).disposed(by: bag)

    useCase.initBirthday().subscribe(onSuccess: {
      output.selectedDate.accept($0)
    }).disposed(by: bag)

    useCase.birthdayValidateState.subscribe(onNext: {
      output.nextButtonDisabled.accept(!$0)
    }).disposed(by: bag)

    useCase.showToastMessage.subscribe(onNext: {
      output.showToast.accept($0)
    }).disposed(by: bag)

    useCase.success.subscribe(onNext: {
      output.present.onNext(())
    }).disposed(by: bag)

    return output
  }
}
