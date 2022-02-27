//
//  VerticalGenderIndicator.swift
//  SeSACFriendsUIKit
//
//  Created by hoseung Lee on 2022/02/27.
//

import UIKit
extension VerticalGenderPicker {
  class Indicator: UIControl {

    lazy var onSelected: Bool = false {
      didSet {
        updateUI()
      }
    }

    var gender: VerticalGenderPicker.Gender

    lazy var text: String = "" {
      didSet {
        label.text = text
      }
    }

    lazy var label: UILabel = {
      let label = UILabel(typoStyle: .title4)
      label.textColor = onSelected ? .seSACWhite : .seSACBlack
      label.textAlignment = .center
      return label
    }()

    override init(frame: CGRect) {
      gender = .none
      super.init(frame: frame)
      backgroundColor = .clear

      addSubview(label)

      label.customLayout(self, [
        .leading(constant: 0),
        .trailing(constant: 0),
        .centerX(constant: 0),
        .centerY(constant: 0),
      ])
    }

    convenience init(frame: CGRect = .zero, gender: VerticalGenderPicker.Gender) {
      self.init(frame: frame)
      self.gender = gender
    }

    required init?(coder: NSCoder) {
      fatalError("Unsupported Initialize")
    }

    private func updateUI() {
      UIView.transition(with: self, duration: 0.2, options: .transitionCrossDissolve) { [unowned self] in
        label.textColor = onSelected ? .seSACWhite : .seSACBlack
      }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      sendActions(for: .touchUpInside)
    }
  }
}
