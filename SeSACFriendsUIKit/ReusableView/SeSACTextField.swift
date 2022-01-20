//
//  SeSACTextField.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/20.
//

import UIKit
import SnapKit

final public class SeSACTextField: UITextField {

  public enum FieldState {
    case inactive
    case focus
    case active
    case disable
    case error
    case success
  }

  private lazy var subTextLabel = UILabel().then {
    $0.font = .body4r
    $0.isHidden = true
  }

  private var bottomBorder = CALayer()
  private var bottomBorderWidth: CGFloat = 1
  private var borderColor: CGColor {
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

  public var subText: String = "" {
    didSet {
      subTextLabel.text = subText
    }
  }

  private var subTextTopConstraint: Constraint?

  public override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func draw(_ rect: CGRect) {

    bottomBorder.frame = CGRect(x: 0, y: frame.height - bottomBorderWidth, width: frame.width, height: bottomBorderWidth)
    layer.addSublayer(bottomBorder)
    
  }

  public override func layoutSubviews() {
    super.layoutSubviews()
    clipsToBounds = true
  }

  private func setupView() {
    addSubview(subTextLabel)
    layoutSetup()
    uiStateUpdate()
  }

  private func layoutSetup() {
    subTextLabel.snp.makeConstraints { make in
      make.leading.trailing.equalTo(snp.leading).inset(12)
      self.subTextTopConstraint = make.top.equalTo(snp.top).constraint
    }
  }

  private func uiStateUpdate() {
    bottomBorder.borderColor = self.borderColor
    bottomBorder.borderWidth = 1
    bottomBorder.backgroundColor = self.borderColor

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
    textColor = .seSACGray3
    layer.cornerRadius = 0
  }

  private func focusUIUpdate() {
    textColor = .seSACBlack
    layer.cornerRadius = 0
  }

  private func activeUIUpdate() {
    textColor = .seSACGray3
    layer.cornerRadius = 0
  }

  private func disableUIUpdate() {
    textColor = .seSACGray7
    backgroundColor = .seSACGray3
    layer.cornerRadius = 4
  }

  private func errorUIUpdate() {
    textColor = .seSACError
    subTextLabel.textColor = .seSACError
    layer.cornerRadius = 0
  }

  private func successUIUpdate() {
    textColor = .seSACSuccess
    subTextLabel.textColor = .seSACSuccess
    layer.cornerRadius = 0
  }

  private func subTextLabelToggle() {
    let currentState = fieldState == .success || fieldState == .error
    let offset = currentState ? 8 : 0
    subTextLabel.snp.updateConstraints { make in
      subTextTopConstraint?.update(offset: offset)
    }
    UIView.animate(withDuration: 0.3) {
      self.subTextLabel.isHidden = !currentState
      self.layoutIfNeeded()
    }

  }

}

#if DEBUG
import SwiftUI
fileprivate struct SeSACTextFieldRP: UIViewRepresentable {
  func makeUIView(context: UIViewRepresentableContext<SeSACTextFieldRP>) -> SeSACTextField {
    SeSACTextField()
  }

  func updateUIView(_ uiView: SeSACTextField, context: Context) {
    uiView.text = "내용을 입력"
    uiView.subText = "출력 메시지 입력"
    uiView.placeholder = "휴대폰 번호(-없이 숫자만 입력)"
    uiView.fieldState = .error
  }
}

struct SeSACTextFieldRP_Previews: PreviewProvider {
  static var previews: some View {
    SeSACTextFieldRP()
      .frame(width: 343, height: 44)
  }
}
#endif
