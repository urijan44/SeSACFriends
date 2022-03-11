//
//  NicknameRootView.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/28.
//

import UIKit
import SeSACFriendsUIKit
import RxSwift

protocol NicknameRootViewDelegate: AnyObject {
  func nicknameCheck()
  func cancelNicknameCheck()
}

final class NicknameRootView: RepresentableView {
  let viewModel: NicknameViewModel
  let bag = DisposeBag()

  lazy var leftBarButtonItem = UIBarButtonItem(image: AssetImage.arrow.image, style: .plain, target: self, action: nil)

  lazy var titleLabel = UILabel(typoStyle: .display1).then {
    $0.text = "닉네임을 입력해 주세요"
  }

  lazy var nickNameTextField = SeSACTextFieldRx().then {
    $0.placeholder = "10자 이내로 입력"
    $0.keyboardType = .default
  }

  lazy var nextButton = SeSACButton(style: .fill).then {
    $0.title = "다음"
    $0.isDisabled = true
  }

  init(frame: CGRect = .zero,
       viewModel: NicknameViewModel,
       delegate: NicknameRootViewDelegate) {
    self.viewModel = viewModel
    self.delegate = delegate
    super.init(frame: frame)
    backgroundColor = .white
  }

  weak var delegate: NicknameRootViewDelegate?

  override func didMoveToWindow() {
    super.didMoveToWindow()
    nickNameTextField.becomeFirstResponder()
  }

  override func createView() {
    addSubview(titleLabel)
    addSubview(nickNameTextField)
    addSubview(nextButton)
  }

  override func layoutConfigure() {
    titleLabel.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(169)
    }

    nickNameTextField.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(16)
      make.top.equalTo(titleLabel.snp.bottom).offset(64)
      make.height.equalTo(88)
    }

    nextButton.snp.makeConstraints { make in
      make.top.equalTo(snp.top).offset(429)
      make.leading.trailing.equalToSuperview().inset(16)
      make.height.equalTo(44)
    }
  }

  override func bind() {
    let input = NicknameViewModel.Input(
      nickNameInput: nickNameTextField.rxText.orEmpty.asObservable(),
      nextButton: nextButton.rx.tap.asObservable())

    let output = viewModel.transform(input)

    output.nextButtonDisabled
      .asDriver()
      .drive(nextButton.rx.isDisabled)
      .disposed(by: bag)

    output.showToast
      .subscribe(onNext: { [weak self] toast in
        let text = toast.sendingMessage
        self?.showToast(text)
      }).disposed(by: bag)

    output.present
      .subscribe(onNext: { [weak self] state in
        if state {
          self?.delegate?.nicknameCheck()
        }
      }).disposed(by: bag)
  }
}
