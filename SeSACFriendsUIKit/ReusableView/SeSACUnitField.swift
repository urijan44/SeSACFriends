//
//  SeSACBirthField.swift
//  SeSACFriendsUIKit
//
//  Created by hoseung Lee on 2022/01/28.
//

import UIKit

open class SeSACUnitField: UIControl {

  public enum FieldState {
    case inactive
    case focus
    case active
    case disable
    case error
    case success
  }

  public lazy var textField: UITextField = {
    let view = UITextField()
    view.isEnabled = false
    view.font = .title4r
    return view
  }()

  private lazy var subTextLabel: UILabel = {
    let view = UILabel()
    view.font = .body4r
    view.isHidden = false
    return view
  }()

  private lazy var unitLabel: UILabel = {
    let label = UILabel()
    label.font = .title2r
    return label
  }()

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

  public var placeholder: String = "" {
    didSet {
      textField.placeholder = placeholder
    }
  }

  private var subText: String = "" {
    didSet {
      subTextLabel.text = subText
    }
  }

  public var keyboardType: UIKeyboardType = .decimalPad {
    didSet {
      textField.keyboardType = self.keyboardType
    }
  }

  public var unitText: String = "" {
    didSet {
      unitLabel.text = unitText
    }
  }

  public override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }

  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public init(frame: CGRect = .zero, unitText: String) {
    super.init(frame: frame)
    self.unitLabel.text = unitText
  }

  public override func layoutSubviews() {
    super.layoutSubviews()
    clipsToBounds = true
    addSubview(bottomBorder)
    addSubview(textField)
    addSubview(subTextLabel)
    addSubview(unitLabel)
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
    unitLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      unitLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      unitLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
    ])
    unitLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 250), for: .horizontal)

    textField.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
      textField.trailingAnchor.constraint(equalTo: unitLabel.leadingAnchor, constant: -12),
      textField.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])

    bottomBorder.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      bottomBorder.leadingAnchor.constraint(equalTo: leadingAnchor),
      bottomBorder.trailingAnchor.constraint(equalTo: unitLabel.leadingAnchor, constant: -4),
      bottomBorder.heightAnchor.constraint(equalToConstant: 1),
      bottomBorder.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 12)
    ])

    subTextLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      subTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
      subTextLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
      subTextLabel.topAnchor.constraint(equalTo: bottomBorder.bottomAnchor, constant: 4)
    ])
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
    textField.textColor = .seSACBlack
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

  public func showSubText(_ text: String, _ type: Bool) {
    self.subText = text
    if type {
      self.fieldState = .success
    } else {
      self.fieldState = .error
    }
  }

  @objc func textFieldChange(_ sender: UITextField) {
    sendActions(for: .editingChanged)
    self.text = sender.text ?? ""
  }
}

#if DEBUG
import SwiftUI
fileprivate struct SeSACUnitFieldRP: UIViewRepresentable {
  func makeUIView(context: UIViewRepresentableContext<SeSACUnitFieldRP>) -> SeSACUnitField {
    SeSACUnitField()
  }

  func updateUIView(_ uiView: SeSACUnitField, context: Context) {
    uiView.text = "1992"
    uiView.unitText = "년"
  }
}

struct SeSACUnitFieldRP_Previews: PreviewProvider {
  static var previews: some View {
    SeSACUnitFieldRP()
  }
}
#endif
