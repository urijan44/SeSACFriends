//
//  SeSACButton.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/20.
//

import UIKit
import SnapKit
import Then

final public class SeSACButton: UIControl {

  public enum Style {
    case fill
    case outline
    case cancel
  }

  public enum State {
    case inactive
    case disabled
  }

  private lazy var containerView = UIView().then {
    $0.layer.cornerRadius = radius
    $0.clipsToBounds = true
  }
  private lazy var titleLabel = UILabel().then {
    $0.textAlignment = .center
    $0.font = .body3r
  }

  private var style: Style = .fill

  public var isInactive: Bool = false {
    didSet {
      updateInactiveView()
      layoutIfNeeded()
    }
  }

  public var isDisabled: Bool = false {
    didSet {
      updateDisabled()
      layoutIfNeeded()
    }
  }

  public var title: String = "" {
    didSet {
      titleLabel.text = title
      layoutIfNeeded()
    }
  }

  private var previousStyle: Style

  public var animateOn: Bool = true

  public var radius: CGFloat = 8

  public override init(frame: CGRect) {
    style = .fill
    previousStyle = style
    super.init(frame: frame)
    viewSetup()
  }

  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func viewSetup() {
    addSubview(containerView)
    containerView.addSubview(titleLabel)
    layoutSetup()
    uiStyleUpdate()
  }

  private func layoutSetup() {
    containerView.snp.makeConstraints { make in
      make.edges.equalTo(self)
    }

    titleLabel.snp.makeConstraints { make in
      make.edges.equalTo(containerView)
    }
  }

  private func uiStyleUpdate() {
    switch style {
      case .fill:
        updateFillView()
      case .outline:
        updateOutline()
      case .cancel:
        updateCancel()
    }
  }

  private func updateFillView() {
    withAnimation { [weak self] in
      self?.containerView.layer.borderWidth = 0
      self?.containerView.backgroundColor = .seSACGreen
      self?.titleLabel.textColor = .seSACWhite
    }
  }

  private func updateOutline() {
    withAnimation { [weak self] in
      self?.containerView.layer.borderColor = .seSACGreen
      self?.containerView.layer.borderWidth = 1
      self?.containerView.backgroundColor = .seSACWhite
      self?.titleLabel.textColor = .seSACGreen
    }
  }

  private func updateCancel() {
    withAnimation { [weak self] in
      self?.containerView.layer.borderWidth = 0
      self?.containerView.backgroundColor = .seSACGray2
      self?.titleLabel.textColor = .seSACBlack
    }
  }

  private func updateInactiveView() {
    if isInactive {
      withAnimation { [weak self] in
        self?.containerView.layer.borderColor = .seSACGray4
        self?.containerView.layer.borderWidth = 1
        self?.containerView.backgroundColor = .seSACWhite
        self?.titleLabel.textColor = .seSACBlack
      }
    } else {
      uiStyleUpdate()
    }
  }

  private func updateDisabled() {
    if isDisabled {
      containerView.layer.borderWidth = 0
      UIView.animate(
        withDuration: 0.1,
        delay: 0,
        options: .transitionCrossDissolve) { [weak self] in
          self?.containerView.backgroundColor = .seSACGray6
          self?.titleLabel.textColor = .seSACGray3
      }
    } else {
      uiStyleUpdate()
    }
  }

  private func withAnimation(_ completion: @escaping (() -> Void)) {
    UIView.animate(
      withDuration: 0.14,
      delay: 0,
      options: .transitionCrossDissolve) {
        completion()
      }
  }

  public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard style == .fill, animateOn else { return }
    UIView.animate(withDuration: 0.1) { [weak self] in
      self?.containerView.backgroundColor = .seSACGreen.withAlphaComponent(0.5)
    }
  }

  public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard style == .fill, animateOn else { return }
    UIView.animate(withDuration: 0.1) { [weak self] in
      self?.containerView.backgroundColor = .seSACGreen.withAlphaComponent(1)
    }
  }
}

public extension SeSACButton {
  convenience init(style: Style) {
    self.init()
    self.style = style
    previousStyle = style
    uiStyleUpdate()
  }
}

#if DEBUG
import SwiftUI
fileprivate struct SeSACButtonRP: UIViewRepresentable {
  func makeUIView(context: UIViewRepresentableContext<SeSACButtonRP>) -> SeSACButton {
    SeSACButton()
  }

  func updateUIView(_ uiView: SeSACButton, context: Context) {
    uiView.title = "버튼 내용"
  }
}

fileprivate struct MyPreviewProvider_Previews: PreviewProvider {
  static var previews: some View {
    SeSACButtonRP()
      .frame(width: 343, height: 48)
  }
}
#endif
