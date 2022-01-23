//
//  RepresentableView.swift
//  SeSACFriendsUIKit
//
//  Created by hoseung Lee on 2022/01/23.
//

import UIKit

open class RepresentableView: UIView {
  override public init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .white
    createView()
    layoutConfigure()
  }

  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  open func createView() { }

  open func layoutConfigure() { }
}
