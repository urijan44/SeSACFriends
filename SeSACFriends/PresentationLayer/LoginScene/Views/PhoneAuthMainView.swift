//
//  PhoneAuthMainView.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/18.
//

import UIKit
import SwiftUI
import SnapKit
import Then
import SeSACFriendsUIKit
import RxSwift
import RxCocoa
import Toast

class PhoneAuthMainView: RepresentableView {

  let viewModel: PhoneAuthViewModel

  lazy var greetingLabel = UILabel(typoStyle: .display1).then {
    $0.numberOfLines = 2
    $0.textAlignment = .center
    $0.text = ""
  }

  lazy var button = SeSACButton(style: .fill).then {
    $0.title = ""
  }

  lazy var textField = SeSACTextField().then {
    $0.placeholder = ""
  }

  var bag = DisposeBag()

  init(frame: CGRect = .zero,
       viewModel: PhoneAuthViewModel)
   {
    self.viewModel = viewModel
    super.init(frame: frame)
    backgroundColor = .seSACWhite
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func createView() {
    super.createView()
    addSubview(greetingLabel)
    addSubview(button)
    addSubview(textField)
  }

  override func layoutConfigure() {
    super.layoutConfigure()
    greetingLabel.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(169)
    }

    textField.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(16)
      make.top.equalTo(greetingLabel.snp.bottom).offset(64)
      make.height.equalTo(88)
    }

    button.snp.makeConstraints { make in
      make.top.equalTo(snp.top).offset(429)
      make.leading.trailing.equalToSuperview().inset(16)
      make.height.equalTo(44)
    }
  }

  override func bind() {
    super.bind()
    
    let input = PhoneAuthViewModel.Input(
      textInput: textField.rxText.orEmpty.asObservable(),
      button: button.rx.controlEvent(.touchUpInside).asObservable())
    let output = viewModel.transform(input)

    output.placeholder
      .asDriver()
      .drive(textField.rx.placeholder)
      .disposed(by: bag)

    output.titleText
      .asDriver()
      .drive(greetingLabel.rx.text)
      .disposed(by: bag)

    output.buttonText
      .asDriver()
      .drive(button.rx.title)
      .disposed(by: bag)

    output.phoneNumberValidateState
      .asDriver()
      .drive(button.rx.isDisabled)
      .disposed(by: bag)

    output.convertPhoneNumberText
      .asDriver()
      .drive(textField.rx.text)
      .disposed(by: bag)

    output.buttonEnable
      .asDriver()
      .drive(button.rx.isEnabled)
      .disposed(by: bag)

    output.showToast
      .subscribe(onNext: { [weak self] toast in
        guard let self = self else { return }
        let text = toast.sendingMessage
        self.textField.showSubText(text, toast.success)
        self.showToast(text)
      }).disposed(by: bag)

//    output.present
//      .subscribe(onNext: { [weak self] _ in
////        self?.delegate?.phoneAuthVetificationCodeCheck()
//      }).disposed(by: bag)
  }
}

#if DEBUG
import SwiftUI
fileprivate struct PhoneAuthMainViewRP: UIViewRepresentable {
  func makeUIView(context: UIViewRepresentableContext<PhoneAuthMainViewRP>) -> PhoneAuthMainView {
    PhoneAuthMainView(viewModel: PhoneAuthViewModel(coordinator: AppDelegateCoordinator(router: AppDelegateRouter(window: UIWindow())), useCase: PhoneAuthUseCase()))
  }

  func updateUIView(_ uiView: PhoneAuthMainView, context: Context) {

  }
}

struct PhoneAuthMainView_Previews: PreviewProvider {
  static var previews: some View {
    PhoneAuthMainViewRP()
  }
}
#endif
