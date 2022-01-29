//
//  ValidateNumberTextField.swift
//  SeSACFriendsUIKit
//
//  Created by hoseung Lee on 2022/01/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

public class ValidateNumberTextField: UIControl {

  public enum FieldState {
    case inactive
    case focus
    case active
    case disable
    case error
    case success
  }

  private lazy var textField = UITextField().then {
    $0.keyboardType = .decimalPad
    $0.font = .title4r
  }

  private lazy var subTextLabel = UILabel().then {
    $0.font = .body4r
    $0.isHidden = false
  }

  public lazy var timeOutLabel = UILabel().then {
    $0.font = .title3m
    $0.textColor = .seSACGreen
    $0.text = "01:00"
  }

  private var bottomBorder = UIView()
  private var bottomBorderWidth: CGFloat = 1
  private var borderColor: UIColor {
    switch fieldState {
      case .inactive:
        return .seSACGray3
      case .focus:
        return .seSACBlack
      case .active:
        return .seSACGray3
      case .disable:
        return .seSACGray3
      case .error:
        return .seSACError
      case .success:
        return .seSACSuccess
    }
  }

  public var fieldState: FieldState = .inactive {
    didSet {
      uiStateUpdate()
    }
  }

  public var text: String = "" {
    didSet {
      textField.text = text
    }
  }

  public lazy var rxText: ControlProperty<String?> = {
    self.textField.rx.text
  }()

  public var placeholder: String = "" {
    didSet {
      textField.placeholder = placeholder
    }
  }

  public var subText: String = "" {
    didSet {
      subTextLabel.text = subText
    }
  }

  public var keyboardType: UIKeyboardType = .decimalPad {
    didSet {
      textField.keyboardType = self.keyboardType
    }
  }

  public override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func layoutSubviews() {
    super.layoutSubviews()
    clipsToBounds = true
    addSubview(bottomBorder)
    addSubview(textField)
    addSubview(subTextLabel)
    addSubview(timeOutLabel)
    layoutSetup()
    uiStateUpdate()
  }

  private func setupView() {
    textField.addTarget(self, action: #selector(textFieldChange(_:)), for: .editingChanged)
    textField.addAction(UIAction() { _ in
      self.fieldState = .focus
    }, for: .editingDidBegin)
  }

  private func layoutSetup() {

    timeOutLabel.snp.makeConstraints { make in
      make.trailing.equalToSuperview().offset(-12)
      make.centerY.equalToSuperview()
    }

    textField.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(12)
      make.trailing.equalTo(timeOutLabel.snp.leading).offset(8).priority(.low)
      make.centerY.equalToSuperview()
    }

    bottomBorder.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.height.equalTo(1)
      make.top.equalTo(textField.snp.bottom).offset(12)
    }

    subTextLabel.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(12)
      make.top.equalTo(bottomBorder.snp.bottom).offset(4)
    }
  }

  private func uiStateUpdate() {
    bottomBorder.backgroundColor = borderColor

    switch fieldState {
      case .inactive:
        inactiveUIUpdate()
      case .focus:
        focusUIUpdate()
      case .active:
        activeUIUpdate()
      case .disable:
        disableUIUpdate()
      case .error:
        errorUIUpdate()
      case .success:
        successUIUpdate()
    }
    subTextLabelToggle()
  }

  private func inactiveUIUpdate() {
    textField.textColor = .seSACGray7
    layer.cornerRadius = 0
  }

  private func focusUIUpdate() {
    textField.textColor = .seSACBlack
    layer.cornerRadius = 0
  }

  private func activeUIUpdate() {
    textField.textColor = .seSACGray3
    layer.cornerRadius = 0
  }

  private func disableUIUpdate() {
    textField.textColor = .seSACGray7
    backgroundColor = .seSACGray3
    layer.cornerRadius = 4
  }

  private func errorUIUpdate() {
    textField.textColor = .seSACBlack
    subTextLabel.textColor = .seSACError
    layer.cornerRadius = 0
  }

  private func successUIUpdate() {
    textField.textColor = .seSACBlack
    subTextLabel.textColor = .seSACSuccess
    layer.cornerRadius = 0
  }

  private func subTextLabelToggle() {
    let currentState = fieldState == .success || fieldState == .error
    UIView.transition(with: subTextLabel, duration: 0.3, options: .transitionCrossDissolve) {
      self.subTextLabel.isHidden = !currentState
    }
  }

  @objc func textFieldChange(_ sender: UITextField) {
    sendActions(for: .editingChanged)
    self.text = sender.text ?? ""
  }
}

#if DEBUG
import SwiftUI
fileprivate struct ValidateNumberTextFieldRP: UIViewRepresentable {
  func makeUIView(context: UIViewRepresentableContext<ValidateNumberTextFieldRP>) -> ValidateNumberTextField {
    ValidateNumberTextField()
  }

  func updateUIView(_ uiView: ValidateNumberTextField, context: Context) {
    uiView.subText = "출력 메시지 입력"
    uiView.placeholder = "인증번호 입력"
    uiView.fieldState = .error
  }
}

struct ValidateNumberTextField_Previews: PreviewProvider {
  static var previews: some View {
    ValidateNumberTextFieldRP()
  }
}
#endif
