//
//  SeSACButton.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/20.
//

import UIKit

final public class SeSACButton: UIControl {

  public enum Style {
    case fill
    case outline
    case cancel
  }

  public enum ButtonState {
    case inactive
    case disabled
  }

  private lazy var containerView: UIView = {
    let view = UIView()
    view.layer.cornerRadius = radius
    view.clipsToBounds = true
    return view
  }()

  private lazy var textLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.font = .body3r
    return label
  }()

  lazy var style: Style = .fill

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
      textLabel.text = title
      layoutIfNeeded()
    }
  }

  public var animateOn: Bool = true
  public var isProgress: Bool = false {
    didSet {
      activityIndicatorHandler()
    }
  }

  private var progressView = UIActivityIndicatorView(style: .medium)

  public var radius: CGFloat = Constant.cornerRadius

  public override init(frame: CGRect) {
    super.init(frame: frame)
    style = .fill
    viewSetup()
  }

  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public init(frame: CGRect = .zero, title: String) {
    self.title = title
    super.init(frame: frame)
  }

  private func viewSetup() {
    addSubview(containerView)
    containerView.addSubview(textLabel)
    layoutSetup()
    uiStyleUpdate()
  }

  private func layoutSetup() {
    containerView.autoresizingMask = [.flexibleHeight ,.flexibleWidth]
    textLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
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

  public func swiftUIBridge() {
    uiStyleUpdate()
  }

  private func updateFillView() {
    withAnimation { [weak self] in
      self?.containerView.layer.borderWidth = 0
      self?.containerView.backgroundColor = .seSACGreen
      self?.textLabel.textColor = .seSACWhite
    }
  }

  private func updateOutline() {
    withAnimation { [weak self] in
      self?.containerView.layer.borderColor = .seSACGreen
      self?.containerView.layer.borderWidth = 1
      self?.containerView.backgroundColor = .seSACWhite
      self?.textLabel.textColor = .seSACGreen
    }
  }

  private func updateCancel() {
    withAnimation { [weak self] in
      self?.containerView.layer.borderWidth = 0
      self?.containerView.backgroundColor = .seSACGray2
      self?.textLabel.textColor = .seSACBlack
    }
  }

  private func updateInactiveView() {
    if isInactive {
      withAnimation { [weak self] in
        self?.containerView.layer.borderColor = .seSACGray4
        self?.containerView.layer.borderWidth = 1
        self?.containerView.backgroundColor = .seSACWhite
        self?.textLabel.textColor = .seSACBlack
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
          self?.textLabel.textColor = .seSACGray3
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
    super.touchesBegan(touches, with: event)
    sendActions(for: .touchUpInside)
    guard style == .fill, animateOn, !isDisabled else { return }
    UIView.animate(withDuration: 0.1) { [weak self] in
      self?.containerView.backgroundColor = .seSACGreen.withAlphaComponent(0.5)
    }
  }

  public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    guard style == .fill, animateOn, !isDisabled else { return }
    UIView.animate(withDuration: 0.1) { [weak self] in
      self?.containerView.backgroundColor = .seSACGreen.withAlphaComponent(1)
    }
  }

  public override func addAction(_ action: UIAction, for controlEvents: UIControl.Event) {
    super.addAction(action, for: controlEvents)
  }

  private func activityIndicatorHandler() {
    if isProgress {
      containerView.addSubview(progressView)
      activityIndicatorLayoutConfigure()
      progressView.startAnimating()
    } else {
      progressView.stopAnimating()
      progressView.removeFromSuperview()
    }
  }

  private func activityIndicatorLayoutConfigure() {
    progressView.customLayout(containerView, [
      .centerX(constant: 0),
      .centerY(constant: 0)
    ])
  }
}

public extension SeSACButton {
  convenience init(style: Style) {
    self.init()
    self.style = style
    uiStyleUpdate()
  }
}
