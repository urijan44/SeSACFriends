//
//  LeafLayout.swift
//  LeafLayoutKit
//
//  Created by hoseung Lee on 2022/02/27.
//

import UIKit
public struct LeafLayout {
  var anchor: Anchor
  var constant: CGFloat
  var target: UIView? = nil
  var targetAnchor: Anchor?

  public enum Anchor {
    case leading
    case trailing
    case top
    case bottom
    case centerX
    case centerY
    case width
    case height

    var nsAnchor: NSLayoutConstraint.Attribute {
      switch self {
        case .leading:
          return .leading
        case .trailing:
          return .trailing
        case .top:
          return .top
        case .bottom:
          return .bottom
        case .centerX:
          return .centerX
        case .centerY:
          return .centerY
        case .width:
          return .width
        case .height:
          return .height
      }
    }
  }
}
