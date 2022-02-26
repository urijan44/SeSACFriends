//
//  GenderPicker.swift
//  SeSACFriendsUIKit
//
//  Created by hoseung Lee on 2022/01/31.
//

import UIKit

open class SeSACGenderPicker: UIControl {
  public enum Gender: Int {
    case male = 1
    case female = 0
    case none = -1
  }

  open var selectedGender: Gender = .none {
    didSet {
      updateUI()
    }
  }

  private lazy var manIndicator: SeSACGenderIndicator = {
    let view = SeSACGenderIndicator(gender: .male)
    view.addTarget(self, action: #selector(tapManIndicator), for: .touchUpInside)
    return view
  }()

  private lazy var womanIndicator: SeSACGenderIndicator = {
    let view = SeSACGenderIndicator(gender: .female)
    view.addTarget(self, action: #selector(tapWomanIndicator), for: .touchUpInside)
    return view
  }()

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
    manIndicator.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      manIndicator.leadingAnchor.constraint(equalTo: leadingAnchor),
      manIndicator.topAnchor.constraint(equalTo: topAnchor),
      manIndicator.bottomAnchor.constraint(equalTo: bottomAnchor),
      manIndicator.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -6)
    ])

    womanIndicator.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      womanIndicator.trailingAnchor.constraint(equalTo: trailingAnchor),
      womanIndicator.topAnchor.constraint(equalTo: topAnchor),
      womanIndicator.bottomAnchor.constraint(equalTo: bottomAnchor),
      womanIndicator.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 6)
    ])
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
