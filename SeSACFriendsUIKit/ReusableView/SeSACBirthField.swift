//
//  DateInputField.swift
//  SeSACFriendsUIKit
//
//  Created by hoseung Lee on 2022/01/28.
//

import UIKit

final public class SeSACBirthField: UIControl {

  public enum FieldState {
    case inactive
    case active
  }

  public var fieldState: FieldState = .inactive {
    didSet {
      updateUI()
    }
  }

  private lazy var containerView: UIStackView = {
    let stackView = UIStackView()
    stackView.addArrangedSubview(yearTextField)
    stackView.addArrangedSubview(monthTextField)
    stackView.addArrangedSubview(dayTextField)
    stackView.distribution = .fillEqually
    stackView.spacing = 10
    stackView.alignment = .fill
    stackView.isUserInteractionEnabled = true
    return stackView
  }()

  private let yearTextField = SeSACUnitField(unitText: "년")
  private let monthTextField = SeSACUnitField(unitText: "월")
  private let dayTextField = SeSACUnitField(unitText: "일")

  public var date: Date = Date() {
    didSet {
      updateField()
    }
  }

  public override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }

  public required init?(coder: NSCoder) {
    fatalError("Dosen't Support Storyboard initialize")
  }

  private func setupView() {
    addSubview(containerView)
    setupLayout()
  }

  private func setupLayout() {
    containerView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
      containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
      containerView.heightAnchor.constraint(equalToConstant: 48),
      containerView.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
  }

  private func updateUI() {
    switch fieldState {
      case .inactive:
        yearTextField.fieldState = .inactive
        monthTextField.fieldState = .inactive
        dayTextField.fieldState = .inactive
      case .active:
        yearTextField.fieldState = .active
        monthTextField.fieldState = .active
        dayTextField.fieldState = .active
    }
  }

  private func updateField() {
    let calendar = Calendar(identifier: .gregorian)
    let components = calendar.dateComponents([.year, .month, .day], from: self.date)

    yearTextField.text = String(components.year ?? 2022)
    monthTextField.text = String(components.month ?? 1)
    dayTextField.text = String(components.day ?? 1)
  }
}

#if DEBUG
import SwiftUI
fileprivate struct SeSACBirthFieldRP: UIViewRepresentable {
  func makeUIView(context: UIViewRepresentableContext<SeSACBirthFieldRP>) -> SeSACBirthField {
    SeSACBirthField()
  }

  func updateUIView(_ uiView: SeSACBirthField, context: Context) {
    uiView.date = Date()
  }
}

struct SeSACBirthFieldRP_Previews: PreviewProvider {
  static var previews: some View {
    SeSACBirthFieldRP()
  }
}
#endif
