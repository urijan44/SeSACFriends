//
//  DateInputField.swift
//  SeSACFriendsUIKit
//
//  Created by hoseung Lee on 2022/01/28.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

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

  private lazy var containerView = UIStackView().then {
    $0.addArrangedSubview(yearTextField)
    $0.addArrangedSubview(monthTextField)
    $0.addArrangedSubview(dayTextField)
    $0.distribution = .fillEqually
    $0.spacing = 10
    $0.alignment = .fill
    $0.isUserInteractionEnabled = true
  }

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
    containerView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.height.equalTo(48)
      make.centerY.equalToSuperview()
    }
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

public extension Reactive where Base: SeSACBirthField {
  var tap: ControlEvent<Void> {
    controlEvent(.touchUpInside)
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
