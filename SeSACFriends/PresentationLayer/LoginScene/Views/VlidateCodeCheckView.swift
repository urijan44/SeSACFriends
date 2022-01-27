//
//  VlidateNumberCheckView.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/25.
//

import UIKit
import RxSwift
import SeSACFriendsUIKit

protocol ValidateCodeCheckViewDeledage: AnyObject {
  func navigatorPush()
  func navigatorPop()
}

class ValidateCodeCheckView: RepresentableView {

  let viewModel: ValidateCodeCheckViewModel
  let bag = DisposeBag()
  lazy var leftBarButtonItem = UIBarButtonItem(image: Images.arrow.image, style: .plain, target: self, action: nil)

  lazy var titleLable1 = UILabel(typoStyle: .display1).then {
    $0.numberOfLines = 1
    $0.textAlignment = .center
    $0.text = "인증번호가 문자로 전송되었습니다."
  }

  lazy var infolabel = UILabel(typoStyle: .title2).then {
    $0.textColor = .seSACGray7
    $0.textAlignment = .center
    $0.text = "(최대 소모 20초)"
  }

  lazy var checkButton = SeSACButton(style: .fill).then {
    $0.title = "인증하고 시작하기"
  }

  lazy var textField = ValidateNumberTextField().then {
    $0.placeholder = "인증번호 입력"
    $0.keyboardType = .decimalPad
  }

  lazy var retryButton = SeSACButton(style: .fill).then {
    $0.title = "재전송"
  }

  weak var delegate: ValidateCodeCheckViewDeledage?

  init(frame: CGRect = .zero,
       viewModel: ValidateCodeCheckViewModel,
       delegate: ValidateCodeCheckViewDeledage?) {
    self.viewModel = viewModel
    self.delegate = delegate
    super.init(frame: frame)
    backgroundColor = .seSACWhite
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func createView() {
    addSubview(titleLable1)
    addSubview(infolabel)
    addSubview(checkButton)
    addSubview(textField)
    addSubview(retryButton)
  }

  override func layoutConfigure() {
    titleLable1.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(169)
    }

    infolabel.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(titleLable1.snp.bottom).offset(8)
    }

    retryButton.snp.makeConstraints { make in
      make.width.equalTo(72)
      make.height.equalTo(40)
      make.centerY.equalTo(textField.snp.centerY)
      make.trailing.equalToSuperview().offset(-16)
    }

    textField.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(16)
      make.trailing.equalTo(retryButton.snp.leading).offset(-8)
      make.top.equalTo(infolabel.snp.bottom).offset(64)
      make.height.equalTo(88)
    }

    checkButton.snp.makeConstraints { make in
      make.top.equalTo(snp.top).offset(429)
      make.leading.trailing.equalToSuperview().inset(16)
      make.height.equalTo(44)
    }
  }

  override func bind() {
    super.bind()
    let input = ValidateCodeCheckViewModel.Input(
      viewAppear: self.rx.methodInvoked(#selector(didMoveToWindow)).map{_ in},
      codeInput: textField.rxText.orEmpty.asObservable(),
      retryButton: retryButton.rx.tap.asObservable(),
      tryAuthentication: checkButton.rx.tap.asObservable(),
      popViewButton: leftBarButtonItem.rx.tap.asObservable()
    )

    let output = viewModel.transform(input)

    output.showToast
      .subscribe(onNext: { [weak self] toast in
        guard let self = self else { return }
        let text = toast.sendingMessage
        self.showToast(text)
      }).disposed(by: bag)

    output.timer
      .asDriver()
      .drive(textField.timeOutLabel.rx.text)
      .disposed(by: bag)

    output.tryButtonEnable
      .asDriver()
      .drive(checkButton.rx.isDisabled)
      .disposed(by: bag)

    output.retryButtonEnable
      .asDriver()
      .drive(retryButton.rx.isDisabled)
      .disposed(by: bag)

    output.retryButtonEnable
      .asDriver()
      .map{!$0}
      .drive(retryButton.rx.isEnabled)
      .disposed(by: bag)

    output.tryButtonBlock
      .asDriver()
      .drive(checkButton.rx.isEnabled)
      .disposed(by: bag)

    leftBarButtonItem.rx.tap
      .subscribe(onNext: { [weak self] _ in
        self?.delegate?.navigatorPop()
      }).disposed(by: bag)
  }
}
#if DEBUG
import SwiftUI
fileprivate struct ValidateNumberCheckViewRP: UIViewRepresentable {
  func makeUIView(context: UIViewRepresentableContext<ValidateNumberCheckViewRP>) -> ValidateCodeCheckView {
    let viewModel = ValidateCodeCheckViewModel(useCase: ValidateCodeUseCase())
    return ValidateCodeCheckView(viewModel: viewModel, delegate: nil)
  }

  func updateUIView(_ uiView: ValidateCodeCheckView, context: Context) {

  }
}

struct ValidateNumberCheckView_Previews: PreviewProvider {
  static var previews: some View {
    ValidateNumberCheckViewRP()
  }
}
#endif
