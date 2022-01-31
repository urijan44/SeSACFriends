//
//  GenderPicker.swift
//  SeSACFriendsUIKit
//
//  Created by hoseung Lee on 2022/01/31.
//

import UIKit
import RxSwift
import RxCocoa

final public class SeSACGenderPicker: UIControl {
  public enum Gender: Int {
    case male = 1
    case female = 0
    case none = -1
  }

  public var selectedGender: Gender = .none {
    didSet {
      gender.accept(selectedGender.rawValue)
      updateUI()
    }
  }

  public lazy var gender: BehaviorRelay<Int> = .init(value: -1)

  private lazy var manIndicator = SeSACGenderIndicator(gender: .male).then {
    $0.addTarget(self, action: #selector(tapManIndicator), for: .touchUpInside)
  }

  private lazy var womanIndicator = SeSACGenderIndicator(gender: .female).then {
    $0.addTarget(self, action: #selector(tapWomanIndicator), for: .touchUpInside)
  }

  public func setGender(_ gender: Gender) {
    self.selectedGender = gender
  }

  public func setGender(_ gender: Int) {
    switch gender {
      case -1:
        setGender(.none)
      case 0:
        setGender(.female)
      default:
        setGender(.male)
    }
  }

  @objc private func tapManIndicator() {
    manIndicator.isSelected = !manIndicator.isSelected
    self.selectedGender = self.selectedGender == .male ? .none : .male
  }

  @objc private func tapWomanIndicator() {
    womanIndicator.isSelected = !womanIndicator.isSelected
    self.selectedGender = self.selectedGender == .female ? .none : .female
  }

  public override init(frame: CGRect) {
    super.init(frame: frame)
    createView()
  }

  public required init?(coder: NSCoder) {
    fatalError("Unsupported Initialize")
  }

  private func createView() {
    addSubview(manIndicator)
    addSubview(womanIndicator)
    layoutConfigure()
  }

  private func layoutConfigure() {
    manIndicator.snp.makeConstraints { make in
      make.leading.top.bottom.equalToSuperview()
      make.trailing.equalTo(snp.centerX).offset(-6)
    }

    womanIndicator.snp.makeConstraints { make in
      make.trailing.top.bottom.equalToSuperview()
      make.leading.equalTo(snp.centerX).offset(6)
    }
  }

  private func updateUI() {
    switch selectedGender {
      case .male:
        manIndicator.isSelected = true
        womanIndicator.isSelected = false
      case .female:
        womanIndicator.isSelected = true
        manIndicator.isSelected = false
      case .none:
        manIndicator.isSelected = false
        womanIndicator.isSelected = false
    }
  }
}

#if DEBUG
import SwiftUI
fileprivate struct SeSACGenderPickerRP: UIViewRepresentable {
  func makeUIView(context: UIViewRepresentableContext<SeSACGenderPickerRP>) -> SeSACGenderPicker {
    SeSACGenderPicker()
  }

  func updateUIView(_ uiView: SeSACGenderPicker, context: Context) {

  }
}

struct SeSACGenderPickerRP_Previews: PreviewProvider {
  static var previews: some View {
    SeSACGenderPickerRP()
      .previewLayout(.sizeThatFits)
      .frame(width: 375, height: 120)
  }
}
#endif
