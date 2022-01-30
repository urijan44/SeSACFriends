//
//  RepresentableView.swift
//  SeSACFriendsUIKit
//
//  Created by hoseung Lee on 2022/01/23.
//

import UIKit
import RxGesture

open class RepresentableView: UIView {

  public override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .white
    createView()
    layoutConfigure()
    bind()
  }

  @available(*, unavailable,
    message: "Loading this view from a nib is unsupported in favor of initializer dependency injection."
  )
  public required init?(coder aDecoder: NSCoder) {
    fatalError("Loading this view from a nib is unsupported in favor of initializer dependency injection.")
  }

  open func createView() { }

  open func layoutConfigure() { }

  open func bind() { }
}
