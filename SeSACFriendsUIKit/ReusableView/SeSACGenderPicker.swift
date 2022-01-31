//
//  GenderPicker.swift
//  SeSACFriendsUIKit
//
//  Created by hoseung Lee on 2022/01/31.
//

import UIKit

final public class SeSACGenderPicker: UIControl {
  public enum Gender {
    case man
    case woman
    case none
  }

  public var gender: Gender = .none {
    didSet {
      updateUI()
    }
  }

  private lazy var manIndicator = SeSACGenderIndicator(gender: .man).then {
    $0.addAction(.init(handler: { _ in
      self.gender = self.gender == .man ? .none : .man
    }), for: .touchUpInside)
  }

  private lazy var womanIndicator = SeSACGenderIndicator(gender: .woman).then {
    $0.addAction(.init(handler: { _ in
      self.gender = self.gender == .woman ? .none : .woman
    }), for: .touchUpInside)
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
    switch gender {
      case .man:
        manIndicator.isSelected = true
        womanIndicator.isSelected = false
      case .woman:
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
