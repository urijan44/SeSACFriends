//
//  EmailRootView.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/31.
//

import UIKit
import SeSACFriendsUIKit
import SnapKit
import RxSwift
import RxGesture
import RxKeyboard

protocol EmailRootViewDelegate: AnyObject {
  func emailCheck()
  func cancelEmailCheck()
}

final class EmailRootView: RepresentableView {

  let viewModel: EmailViewModel
  let bag = DisposeBag()

  lazy var leftBarButtonItem = UIBarButtonItem(image: Images.arrow.image, style: .plain, target: self, action: nil)

  lazy var titleLabel = UILabel(typoStyle: .display1).then {
    $0.text = "이메일을 입력해 주세요"
  }

  lazy var infolabel = UILabel(typoStyle: .title2).then {
    $0.textColor = .seSACGray7
    $0.textAlignment = .center
    $0.text = "휴대폰 번호 변경 시 인증을 위해 사용해요"
  }

  let emailTextField = SeSACTextField().then {
    $0.keyboardType = .emailAddress
    $0.placeholder = "SeSAC@email.com"
  }

  let nextButton = SeSACButton(style: .fill).then {
    $0.title = "다음"
    $0.isDisabled = true
  }

  weak var delegate: EmailRootViewDelegate?

  init(frame: CGRect = .zero,
       viewModel: EmailViewModel,
       delegate: EmailRootViewDelegate?) {
    self.viewModel = viewModel
    self.delegate = delegate
    super.init(frame: frame)
    backgroundColor = .white
    emailTextField.becomeFirstResponder()
  }

  override func createView() {
    addSubview(titleLabel)
    addSubview(infolabel)
    addSubview(emailTextField)
    addSubview(nextButton)
  }

  override func layoutConfigure() {
    titleLabel.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(169)
    }

    infolabel.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(titleLabel.snp.bottom).offset(8)
    }

    emailTextField.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(16)
      make.top.equalTo(infolabel.snp.bottom).offset(64)
      make.height.equalTo(88)
    }

    nextButton.snp.makeConstraints { make in
      make.top.equalTo(snp.top).offset(429)
      make.leading.trailing.equalToSuperview().inset(16)
      make.height.equalTo(44)
    }
  }

  override func bind() {

    let input = EmailViewModel.Input(
      view: self,
      viewTap: self.rx.tapGesture().asObservable(),
      keyboardSize: RxKeyboard.instance.frame.asObservable(),
      viewAppear: self.rx.methodInvoked(#selector(UIView.didMoveToWindow)).map{_ in},
      emailInput: emailTextField.rxText.orEmpty.asObservable(),
      nextButton: nextButton.rx.tap.asObservable())

    let output = viewModel.transform(input)

    output.nextButtonDisabled.asDriver()
      .drive(nextButton.rx.isDisabled)
      .disposed(by: bag)

    output.showToast.subscribe(onNext: { [weak self] toast in
      let message = toast.sendingMessage
      self?.showToast(message)
    }).disposed(by: bag)

    output.hideKeyboard.subscribe(onNext: { [weak self] _ in
      self?.emailTextField.resignFirstResponder()
    }).disposed(by: bag)

    output.present.subscribe(onNext: { [weak self] _ in
      self?.delegate?.emailCheck()
    }).disposed(by: bag)

    leftBarButtonItem.rx.tap.subscribe(onNext: { [weak self] _ in
      self?.delegate?.cancelEmailCheck()
    }).disposed(by: bag)
  }
}
