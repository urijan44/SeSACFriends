//
//  VerticalGenderPicker.swift
//  SeSACFriendsUIKit
//
//  Created by hoseung Lee on 2022/02/26.
//

import UIKit
import LeafLayoutKit
import SwiftUI

final public class VerticalGenderPicker: UIControl {

  public enum Gender: Int {
    case none = -1
    case female = 0
    case male = 1
  }

  public var gender: Gender = .none {
    didSet {
      updateUI()
      publisher?(gender)
    }
  }

  public var publisher: ((Gender) -> Void)?

  private var height: CGFloat = 0
  private var containerView: UIView = {
    let view = UIView()
    view.backgroundColor = .seSACWhite
    view.layer.cornerRadius = 8
    view.clipsToBounds = true
    return view
  }()

  private lazy var noneIndicator: Indicator = {
    let view = Indicator(gender: .none)
    view.text = "전체"
    view.addTarget(self, action: #selector(changeGender(_:)), for: .touchUpInside)
    return view
  }()

  private lazy var maleIndicator: Indicator = {
    let view = Indicator(gender: .male)
    view.text = "남자"
    view.addTarget(self, action: #selector(changeGender(_:)), for: .touchUpInside)
    return view
  }()

  private lazy var femaleIndicator: Indicator = {
    let view = Indicator(gender: .female)
    view.text = "여자"
    view.addTarget(self, action: #selector(changeGender(_:)), for: .touchUpInside)
    return view
  }()

  @objc func changeGender(_ indicator: Indicator) {
    self.gender = indicator.gender
  }

  private lazy var selectIndicator: UIView = {
    let view = UIView()
    view.backgroundColor = .seSACGreen
    return view
  }()

  private var selectIndicatorTopConstraint: NSLayoutConstraint!
  private var selectIndicatorHeightConstraint: NSLayoutConstraint!

  private func updateUI(animate: Bool = true) {
    isUserInteractionEnabled = false
    switch gender {
      case .none:
        selectIndicatorTopConstraint.constant = 0
      case .male:
        selectIndicatorTopConstraint.constant = height
      case .female:
        selectIndicatorTopConstraint.constant = height * 2
    }

    if animate {
      UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseIn) { [unowned self] in
        layoutIfNeeded()
      } completion: { [unowned self] _ in
        [noneIndicator, maleIndicator, femaleIndicator].forEach { indicator in
          indicator.onSelected = indicator.gender == gender
        }
        self.isUserInteractionEnabled = true
      }
    } else {
      layoutIfNeeded()
      self.isUserInteractionEnabled = true
    }
  }

  private override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .clear
  }

  public convenience init(frame: CGRect = .zero, viewWidth: CGFloat) {
    self.init(frame: frame)
    self.height = viewWidth
    createView()
    layoutConfigure(viewWidth: viewWidth)
    layer.shadowColor = .seSACBlack
    layer.shadowRadius = 1
    layer.shadowOffset = .init(width: 0, height: 1)
    layer.shadowOpacity = 0.5
    updateUI(animate: false)
  }

  public required init?(coder: NSCoder) {
    fatalError("Unsupported Initializer")
  }

  public override func draw(_ rect: CGRect) {
    guard let context = UIGraphicsGetCurrentContext() else { return }
    let clipPath = UIBezierPath(roundedRect: rect, cornerRadius: Constant.cornerRadius).cgPath
    context.addPath(clipPath)
    context.setFillColor(UIColor.seSACError.cgColor)
    context.closePath()
    context.fillPath()
  }

  private func createView() {
    addSubview(containerView)
    containerView.addSubview(selectIndicator)
    addSubview(noneIndicator)
    addSubview(maleIndicator)
    addSubview(femaleIndicator)
  }

  private func layoutConfigure(viewWidth: CGFloat) {
    let height = viewWidth

    containerView.customLayout(self, [
      .leading(constant: 0),
      .trailing(constant: 0),
      .top(constant: 0),
      .bottom(constant: 0)
    ])

    selectIndicator.customLayout(self, [
      .leading(constant: 0),
      .width(constant: frame.width),
    ])
    selectIndicatorTopConstraint = selectIndicator.topAnchor.constraint(equalTo: noneIndicator.topAnchor)
    selectIndicatorTopConstraint.isActive = true
    selectIndicatorHeightConstraint = selectIndicator.heightAnchor.constraint(equalToConstant: height)
    selectIndicatorHeightConstraint.isActive = true

    noneIndicator.customLayout(self, [
      .leading(constant: 0),
      .trailing(constant: 0),
      .top(constant: 0),
      .height(constant: height)
    ])

    maleIndicator.customLayout(self, [
      .leading(constant: 0),
      .trailing(constant: 0),
      .top(constant: 0, target: noneIndicator, anchor: .bottom),
      .height(constant: height)
    ])

    femaleIndicator.customLayout(self, [
      .leading(constant: 0),
      .trailing(constant: 0),
      .top(constant: 0, target: maleIndicator, anchor: .bottom),
      .height(constant: height)
    ])

  }
}

struct VerticalGenderPickerUI: UIViewRepresentable {

  let viewWidth: CGFloat

  func makeUIView(context: Context) -> VerticalGenderPicker {
    VerticalGenderPicker(viewWidth: viewWidth)
  }

  func updateUIView(_ uiView: VerticalGenderPicker, context: Context) {

  }
}

struct VerticalGenderPickerUI_Previews: PreviewProvider {
  static var previews: some View {
    VerticalGenderPickerUI(viewWidth: 48)
      .frame(width: 48, height: 144)
      .previewLayout(.sizeThatFits)
  }
}
