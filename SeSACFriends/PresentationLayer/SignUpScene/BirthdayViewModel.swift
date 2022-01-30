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

  let bag = DisposeBag()

  struct Input {
    let view: UIView
    let viewTap: Observable<UITapGestureRecognizer>
    let tapTextField: Observable<UITapGestureRecognizer>
    let dateInput: Observable<Date>
    let nextButton: Observable<Void>
  }

  struct Output {
    let nextButtonDisabled: BehaviorRelay<Bool> = .init(value: false)
//    let showToast =
    let showDatePicker: PublishSubject<Void> = .init()
    let hideDatePicker: PublishSubject<Void> = .init()
    let selectedDate: BehaviorRelay<Date> = .init(value: Date())
    let birthFieldActiveState: BehaviorRelay<Bool> = .init(value: false)
    let present: PublishSubject<Void> = .init()
  }

  func transform(_ input: Input) -> Output {
    let output = Output()

    input.dateInput.subscribe(onNext: { date in
      output.selectedDate.accept(date)
    }).disposed(by: bag)

    input.tapTextField.subscribe(onNext: { _ in
      output.showDatePicker.onNext(())
      output.birthFieldActiveState.accept(true)
    }).disposed(by: bag)

    input.viewTap.subscribe(onNext: { [weak self] gesture in
      guard let self = self else { return }
      if gesture.location(in: input.view).y < input.view.bounds.maxY - self.datePickerSize {
        output.birthFieldActiveState.accept(false)
        output.hideDatePicker.onNext(())
      }
    }).disposed(by: bag)

    return output
  }
}
