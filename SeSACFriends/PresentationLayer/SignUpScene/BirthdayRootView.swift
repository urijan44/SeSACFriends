//
//  BirthdayRootView.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/30.
//

import UIKit
import SeSACFriendsUIKit
import SnapKit
import RxSwift
import RxGesture

protocol BirthdayRootViewDelegate: AnyObject {
  func birthdayCheck()
  func cancelBirthdayCheck()
}

final class BirthdayRootView: RepresentableView {
  let viewModel: BirthdayViewModel
  let bag = DisposeBag()

  lazy var leftBarButtonItem = UIBarButtonItem(image: Images.arrow.image, style: .plain, target: self, action: nil)

  lazy var titleLabel = UILabel(typoStyle: .display1).then {
    $0.text = "생년월일을 알려주세요"
  }

  let birthdayInputField = SeSACBirthField().then {
    $0.isUserInteractionEnabled = true
  }

  let datePicker = UIDatePicker().then {
    $0.preferredDatePickerStyle = .wheels
    $0.datePickerMode = .date
    $0.setValue(UIColor.systemGray, forKey: "BackgroundColor")
  }

  private var pickersHeight: Constraint? = nil

  let nextButton = SeSACButton(style: .fill).then {
    $0.title = "다음"
    $0.isDisabled = true
  }

  weak var delegate: BirthdayRootViewDelegate?

  init(frame: CGRect = .zero,
       viewModel: BirthdayViewModel,
       delegate: BirthdayRootViewDelegate?) {
    self.viewModel = viewModel
    self.delegate = delegate
    super.init(frame: frame)
    backgroundColor = .white
  }

  override func createView() {
    addSubview(titleLabel)
    addSubview(birthdayInputField)
    addSubview(nextButton)
    addSubview(datePicker)
  }

  override func layoutConfigure() {
    titleLabel.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(169)
    }

    birthdayInputField.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(16)
      make.top.equalTo(titleLabel.snp.bottom).offset(64)
      make.height.equalTo(88)
    }

    nextButton.snp.makeConstraints { make in
      make.top.equalTo(snp.top).offset(429)
      make.leading.trailing.equalToSuperview().inset(16)
      make.height.equalTo(44)
    }

    datePicker.snp.makeConstraints { make in
      make.leading.trailing.bottom.equalToSuperview()
      pickersHeight = make.height.equalTo(0).constraint
    }
  }

  private func showDatePicker() {
    pickersHeight?.update(offset: viewModel.datePickerSize)
    withAnimate()
  }

  private func hideDatePicker() {
    pickersHeight?.update(offset: 0)
    withAnimate()
  }

  private func withAnimate() {
    UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: []) {
      self.layoutIfNeeded()
    }
  }

  override func bind() {
    let input = BirthdayViewModel.Input(
      view: self,
      viewAppear: self.rx.methodInvoked(#selector(UIView.didMoveToWindow)).map{_ in},
      viewTap: self.rx.tapGesture().asObservable(),
      tapTextField: birthdayInputField.rx.tapGesture().asObservable(),
      dateInput: datePicker.rx.date.asObservable(),
      nextButton: nextButton.rx.tap.asObservable())

    let output = viewModel.transform(input)

    output.nextButtonDisabled.asDriver()
      .drive(nextButton.rx.isDisabled)
      .disposed(by: bag)

    output.showToast.subscribe(onNext: { [weak self] toast in
      let text = toast.sendingMessage
      self?.showToast(text)
    }).disposed(by: bag)

    output.hideDatePicker.subscribe(onNext: { [weak self] _ in
      self?.hideDatePicker()
    }).disposed(by: bag)

    output.showDatePicker.subscribe(onNext: { [weak self] _ in
      self?.showDatePicker()
    }).disposed(by: bag)

    output.selectedDate.asDriver()
      .drive(birthdayInputField.rx.date)
      .disposed(by: bag)

    output.birthFieldActiveState.asDriver()
      .map { state in
        if state {
          return SeSACBirthField.FieldState.active
        } else {
          return SeSACBirthField.FieldState.inactive
        }
      }
      .drive(birthdayInputField.rx.fieldState)
      .disposed(by: bag)

    output.present.subscribe(onNext: { [weak self] _ in
      self?.delegate?.birthdayCheck()
    }).disposed(by: bag)

    leftBarButtonItem.rx.tap
      .subscribe(onNext: { [weak self] _ in
        self?.delegate?.cancelBirthdayCheck()
      }).disposed(by: bag)
  }
}
